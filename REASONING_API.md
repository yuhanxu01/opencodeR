# 深度思考 API 使用文档

## 概述

OpenCode 现在提供了独立的深度思考 API，专门用于推理和写作论证场景。这个 API 与原有的 code agent API 完全分离，使用专门的推理模型（如 DeepSeek Reasoner）来提供详细的思维链和深思熟虑的答案。

## 关键特性

- **独立 API**：与原有的 session API 分离，保持 code agent 的轻量级
- **思维链输出**：返回完整的推理过程（reasoning_content）和最终答案（content）
- **支持多种模式**：
  - 单次请求模式
  - 多轮对话模式
  - 流式响应模式
- **DeepSeek Reasoner 优化**：自动启用 thinking mode

## API 端点

### 1. 单次深度思考请求

**端点**: `POST /reasoning/prompt`

**请求示例**:

```bash
curl -X POST http://localhost:4096/reasoning/prompt \
  -H "Content-Type: application/json" \
  -d '{
    "model": {
      "providerID": "deepseek",
      "modelID": "deepseek-reasoner"
    },
    "prompt": "解释量子纠缠的概念，并说明它在量子计算中的应用",
    "maxTokens": 32000,
    "enableThinking": true
  }'
```

**请求参数**:

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| model.providerID | string | 是 | 提供商 ID，如 "deepseek" |
| model.modelID | string | 是 | 模型 ID，如 "deepseek-reasoner" |
| prompt | string | 是 | 需要深度思考的问题或提示 |
| context | string | 否 | 可选的上下文信息 |
| maxTokens | number | 否 | 最大 token 数（默认 32K，最大 64K） |
| temperature | number | 否 | 温度参数（注意：推理模型可能不支持） |
| stream | boolean | 否 | 是否启用流式响应（默认 false） |
| enableThinking | boolean | 否 | 是否启用 thinking mode（默认 true） |

**响应示例**:

```json
{
  "reasoningContent": "首先，我需要理解量子纠缠的基本概念...[详细的思维链]",
  "content": "量子纠缠是量子力学中的一种现象，当两个或多个粒子以某种方式相互作用后...[最终答案]",
  "usage": {
    "promptTokens": 45,
    "completionTokens": 1250,
    "totalTokens": 1295
  }
}
```

### 2. 多轮对话深度思考

**端点**: `POST /reasoning/multi-turn`

**请求示例**:

```bash
curl -X POST http://localhost:4096/reasoning/multi-turn \
  -H "Content-Type: application/json" \
  -d '{
    "model": {
      "providerID": "deepseek",
      "modelID": "deepseek-reasoner"
    },
    "history": [
      {
        "role": "user",
        "content": "什么是机器学习？"
      },
      {
        "role": "assistant",
        "content": "机器学习是人工智能的一个分支..."
      }
    ],
    "prompt": "那么深度学习和机器学习有什么区别？",
    "maxTokens": 32000
  }'
```

**重要提示**：
- 在多轮对话中，历史记录中**不应包含** `reasoning_content` 字段，只保留 `content` 字段
- 这样可以节省带宽和 token 使用

### 3. 流式响应

**请求示例**:

```bash
curl -X POST http://localhost:4096/reasoning/prompt \
  -H "Content-Type: application/json" \
  -d '{
    "model": {
      "providerID": "deepseek",
      "modelID": "deepseek-reasoner"
    },
    "prompt": "分析气候变化对全球经济的影响",
    "stream": true
  }'
```

**流式响应格式**:

```json
{"type":"text-delta","content":"气候"}
{"type":"text-delta","content":"变化"}
{"type":"reasoning-content","content":"让我分析这个问题..."}
{"type":"final","reasoningContent":"...","content":"...","usage":{...}}
```

## 使用场景

### 1. 学术研究和论证

```javascript
const response = await fetch('http://localhost:4096/reasoning/prompt', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    model: {
      providerID: 'deepseek',
      modelID: 'deepseek-reasoner'
    },
    prompt: '分析人工智能对就业市场的长期影响，并提供论证',
    maxTokens: 64000
  })
});

const data = await response.json();
console.log('思维链:', data.reasoningContent);
console.log('最终答案:', data.content);
```

### 2. 复杂问题求解

```python
import requests

response = requests.post('http://localhost:4096/reasoning/prompt', json={
    'model': {
        'providerID': 'deepseek',
        'modelID': 'deepseek-reasoner'
    },
    'prompt': '如何设计一个高可用的分布式系统？请详细分析各种方案的优劣',
    'context': '系统需要支持每秒10万次请求，数据一致性要求高',
    'maxTokens': 32000
})

result = response.json()
print(f"推理过程: {result['reasoningContent']}")
print(f"结论: {result['content']}")
```

### 3. Agent 触发深度思考

在 code agent 中，可以在需要深度推理时调用此 API：

```typescript
// 在 agent 代码中
async function performDeepReasoning(question: string) {
  const response = await fetch('http://localhost:4096/reasoning/prompt', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      model: {
        providerID: 'deepseek',
        modelID: 'deepseek-reasoner'
      },
      prompt: question,
      enableThinking: true
    })
  });

  return await response.json();
}

// Agent 在遇到需要深度分析的任务时
if (requiresDeepAnalysis) {
  const reasoning = await performDeepReasoning(userQuery);
  // 使用推理结果继续工作
}
```

## 与原有 Session API 的对比

| 特性 | Session API (`/session/:id/message`) | Reasoning API (`/reasoning/prompt`) |
|------|--------------------------------------|-------------------------------------|
| **用途** | Code agent，代码生成和执行 | 深度推理，论证和分析 |
| **思维链** | 不提供 | 提供完整的 reasoning_content |
| **会话管理** | 需要创建和管理 session | 无需 session，独立请求 |
| **工具调用** | 支持丰富的工具集 | 专注于纯推理 |
| **响应速度** | 较快 | 较慢（深度思考需要时间） |
| **Token 使用** | 较少 | 较多（包含思维链） |

## 配置 DeepSeek Provider

确保在配置文件中设置了 DeepSeek API 密钥：

```bash
# 环境变量
export DEEPSEEK_API_KEY="your-api-key"

# 或在 opencode 配置文件中
{
  "provider": {
    "deepseek": {
      "apiKey": "your-api-key"
    }
  }
}
```

## 错误处理

```javascript
try {
  const response = await fetch('http://localhost:4096/reasoning/prompt', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      model: { providerID: 'deepseek', modelID: 'deepseek-reasoner' },
      prompt: 'Your question here'
    })
  });

  if (!response.ok) {
    const error = await response.json();
    console.error('API Error:', error);
    throw new Error(error.message);
  }

  const data = await response.json();
  // 处理响应
} catch (error) {
  console.error('Request failed:', error);
}
```

## 性能优化建议

1. **控制 maxTokens**：根据实际需求设置，避免不必要的长输出
2. **多轮对话优化**：移除历史记录中的 `reasoning_content`
3. **使用流式响应**：对于实时展示场景，使用 `stream: true`
4. **缓存结果**：对于相同或相似的问题，考虑缓存推理结果

## 限制和注意事项

1. DeepSeek Reasoner 模型不支持以下参数（会被忽略）：
   - `temperature`
   - `top_p`
   - `presence_penalty`
   - `frequency_penalty`

2. 不支持设置 `logprobs` 或 `top_logprobs`（会导致错误）

3. 推理过程可能需要较长时间，建议设置合理的超时时间

4. 思维链内容较长，注意 token 限制和成本

## 总结

深度思考 API 为 OpenCode 提供了专业的推理能力，适用于需要详细分析和论证的场景。通过将其与原有的 code agent API 分离，我们确保了：

- ✅ Code agent 保持轻量级和快速响应
- ✅ 推理任务获得充分的思考时间和 token 预算
- ✅ 开发者可以根据场景选择合适的 API
- ✅ 系统架构清晰，易于维护和扩展
