import { Hono } from "hono"
import { describeRoute, validator, resolver } from "hono-openapi"
import z from "zod"
import { Provider } from "../../provider/provider"
import { errors } from "../error"
import { lazy } from "../../util/lazy"
import { Log } from "../../util/log"
import { generateText, streamText } from "ai"
import { stream } from "hono/streaming"

const log = Log.create({ service: "reasoning" })

export namespace Reasoning {
  /**
   * 深度思考请求输入
   */
  export const ReasoningInput = z.object({
    model: z.object({
      providerID: z.string().meta({ description: "Provider ID (e.g., 'deepseek')" }),
      modelID: z.string().meta({ description: "Model ID (e.g., 'deepseek-reasoner')" }),
    }),
    prompt: z.string().meta({ description: "The question or prompt for deep thinking" }),
    context: z.string().optional().meta({ description: "Optional context for the reasoning task" }),
    maxTokens: z
      .number()
      .optional()
      .default(32000)
      .meta({ description: "Maximum tokens including reasoning chain (default 32K, max 64K)" }),
    temperature: z.number().optional().meta({ description: "Temperature (note: may not be effective for reasoner models)" }),
    stream: z.boolean().optional().default(false).meta({ description: "Enable streaming response" }),
    enableThinking: z
      .boolean()
      .optional()
      .default(true)
      .meta({ description: "Enable thinking mode via extra_body parameter" }),
  })
  export type ReasoningInput = z.infer<typeof ReasoningInput>

  /**
   * 深度思考响应输出
   */
  export const ReasoningOutput = z.object({
    reasoningContent: z.string().optional().meta({ description: "The thinking chain content" }),
    content: z.string().meta({ description: "The final answer" }),
    usage: z
      .object({
        promptTokens: z.number(),
        completionTokens: z.number(),
        totalTokens: z.number(),
      })
      .optional(),
  })
  export type ReasoningOutput = z.infer<typeof ReasoningOutput>
}

export const ReasoningRoutes = lazy(() =>
  new Hono()
    .post(
      "/prompt",
      describeRoute({
        summary: "Deep thinking prompt",
        description:
          "Submit a prompt for deep thinking and reasoning. This endpoint uses specialized reasoning models like DeepSeek Reasoner to provide detailed thinking chains and well-reasoned answers. Separate from the standard code agent API.",
        operationId: "reasoning.prompt",
        responses: {
          200: {
            description: "Reasoning response with thinking chain and final answer",
            content: {
              "application/json": {
                schema: resolver(Reasoning.ReasoningOutput),
              },
            },
          },
          ...errors(400, 500),
        },
      }),
      validator("json", Reasoning.ReasoningInput),
      async (c) => {
        const body = c.req.valid("json")

        try {
          // Get the provider and model
          const provider = await Provider.forModel({
            providerID: body.model.providerID,
            modelID: body.model.modelID,
          })

          const model = provider(body.model.modelID)

          // Build the prompt
          const messages = [
            {
              role: "user" as const,
              content: body.context
                ? `${body.context}\n\n${body.prompt}`
                : body.prompt,
            },
          ]

          // Prepare extra options for thinking mode
          const extraOptions: any = {}
          if (body.enableThinking) {
            // Enable thinking mode via extra_body
            extraOptions.experimental_providerMetadata = {
              extra_body: {
                thinking: { type: "enabled" },
              },
            }
          }

          if (body.stream) {
            // Streaming response
            c.status(200)
            c.header("Content-Type", "application/json")
            c.header("Transfer-Encoding", "chunked")

            return stream(c, async (stream) => {
              const result = await streamText({
                model,
                messages,
                maxTokens: body.maxTokens,
                ...(body.temperature !== undefined && { temperature: body.temperature }),
                ...extraOptions,
              })

              let reasoningContent = ""
              let textContent = ""

              for await (const chunk of result.fullStream) {
                if (chunk.type === "text-delta") {
                  textContent += chunk.textDelta
                  await stream.write(JSON.stringify({
                    type: "text-delta",
                    content: chunk.textDelta,
                  }) + "\n")
                } else if (chunk.type === "response-metadata") {
                  // For DeepSeek reasoner, reasoning content might be in metadata
                  const metadata = chunk as any
                  if (metadata.reasoning_content) {
                    reasoningContent = metadata.reasoning_content
                    await stream.write(JSON.stringify({
                      type: "reasoning-content",
                      content: reasoningContent,
                    }) + "\n")
                  }
                }
              }

              // Send final response
              const usage = await result.usage
              await stream.write(JSON.stringify({
                type: "final",
                reasoningContent,
                content: textContent,
                usage: {
                  promptTokens: usage.promptTokens,
                  completionTokens: usage.completionTokens,
                  totalTokens: usage.totalTokens,
                },
              }) + "\n")
            })
          } else {
            // Non-streaming response
            const result = await generateText({
              model,
              messages,
              maxTokens: body.maxTokens,
              ...(body.temperature !== undefined && { temperature: body.temperature }),
              ...extraOptions,
            })

            // Extract reasoning content if available
            // DeepSeek reasoner returns reasoning_content in the response
            const reasoningContent = (result as any).reasoning_content ||
                                   (result.response as any)?.messages?.[0]?.reasoning_content ||
                                   (result.response as any)?.body?.choices?.[0]?.message?.reasoning_content

            return c.json({
              reasoningContent,
              content: result.text,
              usage: {
                promptTokens: result.usage.promptTokens,
                completionTokens: result.usage.completionTokens,
                totalTokens: result.usage.totalTokens,
              },
            })
          }
        } catch (error) {
          log.error("reasoning failed", { error })
          throw error
        }
      },
    )
    .post(
      "/multi-turn",
      describeRoute({
        summary: "Multi-turn deep thinking",
        description:
          "Continue a multi-turn reasoning conversation. For DeepSeek reasoner, previous reasoning_content should be excluded from history to save bandwidth.",
        operationId: "reasoning.multiTurn",
        responses: {
          200: {
            description: "Reasoning response",
            content: {
              "application/json": {
                schema: resolver(Reasoning.ReasoningOutput),
              },
            },
          },
          ...errors(400, 500),
        },
      }),
      validator(
        "json",
        Reasoning.ReasoningInput.extend({
          history: z.array(
            z.object({
              role: z.enum(["user", "assistant"]),
              content: z.string(),
              // Note: Do NOT include reasoning_content in history for DeepSeek reasoner
            }),
          ).meta({ description: "Conversation history (exclude reasoning_content for efficiency)" }),
        }),
      ),
      async (c) => {
        const body = c.req.valid("json") as any

        try {
          const provider = await Provider.forModel({
            providerID: body.model.providerID,
            modelID: body.model.modelID,
          })

          const model = provider(body.model.modelID)

          // Build messages from history + new prompt
          const messages = [
            ...body.history.map((msg: any) => ({
              role: msg.role,
              content: msg.content,
            })),
            {
              role: "user" as const,
              content: body.context
                ? `${body.context}\n\n${body.prompt}`
                : body.prompt,
            },
          ]

          // Prepare extra options for thinking mode
          const extraOptions: any = {}
          if (body.enableThinking) {
            extraOptions.experimental_providerMetadata = {
              extra_body: {
                thinking: { type: "enabled" },
              },
            }
          }

          const result = await generateText({
            model,
            messages,
            maxTokens: body.maxTokens,
            ...(body.temperature !== undefined && { temperature: body.temperature }),
            ...extraOptions,
          })

          const reasoningContent = (result as any).reasoning_content ||
                                 (result.response as any)?.messages?.[0]?.reasoning_content ||
                                 (result.response as any)?.body?.choices?.[0]?.message?.reasoning_content

          return c.json({
            reasoningContent,
            content: result.text,
            usage: {
              promptTokens: result.usage.promptTokens,
              completionTokens: result.usage.completionTokens,
              totalTokens: result.usage.totalTokens,
            },
          })
        } catch (error) {
          log.error("multi-turn reasoning failed", { error })
          throw error
        }
      },
    ),
)
