import time
from .models import APIConfiguration
from .tools import scan_uploaded_files, categorize_literature, move_file

def save_api_config(configs):
    for conf in configs:
        provider = conf.get('provider')
        key = conf.get('key')
        if provider and key:
            obj, created = APIConfiguration.objects.get_or_create(provider_name=provider)
            obj.api_key = key
            obj.save()

def run_agent(message):
    """
    Main Agent Loop.
    For this MVP/Demo, we use heuristic keywords to trigger tool chains.
    In a real implementation, this would call the LLM with tool definitions.
    """
    
    # 1. Detect Intent
    msg_lower = message.lower()
    tool_events = []
    final_content = "I didn't understand that command."
    
    if "organize" in msg_lower or "整理" in msg_lower:
        final_content = "I have organized your literature files."
        
        # Step 1: Scan
        tool_events.append({
            "tool_name": "scan_uploaded_files",
            "status": "running",
            "input": {},
            "output": None
        })
        # Simulate delay
        time.sleep(0.5) 
        
        files = scan_uploaded_files()
        
        tool_events[-1]["status"] = "success"
        tool_events[-1]["output"] = {"files_found": files}
        
        if not files:
            final_content = "I scanned the uploads folder but found no files to organize."
        
        # Step 2: Categorize & Move
        for f in files:
            # Categorize
            tool_events.append({
                "tool_name": "categorize_literature",
                "status": "running",
                "input": {"filename": f},
                "output": None
            })
            time.sleep(0.5)
            
            cat_result = categorize_literature(f)
            tool_events[-1]["status"] = "success"
            tool_events[-1]["output"] = cat_result
            
            category = cat_result.get('category', 'uncategorized')
            
            # Move
            tool_events.append({
                "tool_name": "move_file",
                "status": "running",
                "input": {"filename": f, "target": category},
                "output": None
            })
            time.sleep(0.3)
            
            move_result = move_file(f, category)
            tool_events[-1]["status"] = "success"
            tool_events[-1]["output"] = move_result

    elif "list" in msg_lower and ("files" in msg_lower or "dir" in msg_lower):
        # General Code Tool: List
        from .tools import list_files
        path = "." # Mock: Extract path from message if complex
        
        tool_events.append({
            "tool_name": "list_files",
            "status": "running",
            "input": {"path": path},
            "output": None
        })
        time.sleep(0.5)
        
        res = list_files(path)
        tool_events[-1]["status"] = "success"
        tool_events[-1]["output"] = res
        final_content = f"Here are the files in {path}."

    elif "read" in msg_lower or "view" in msg_lower:
        # General Code Tool: Read
        from .tools import read_file
        # Hacky filename extraction for mock
        filename = message.split()[-1] 
        
        tool_events.append({
            "tool_name": "read_file",
            "status": "running",
            "input": {"file": filename},
            "output": None
        })
        time.sleep(0.5)
        
        res = read_file(filename)
        if "error" in res:
            tool_events[-1]["status"] = "error"
            final_content = f"Could not read {filename}: {res['error']}"
        else:
            tool_events[-1]["status"] = "success"
            final_content = f"Content of {filename}:\n\n{res['content'][:500]}..."
        tool_events[-1]["output"] = res

    elif "bash" in msg_lower or "run" in msg_lower:
        # General Code Tool: Bash
        from .tools import execute_bash
        # Simplified: treat the rest of the message as the command
        cmd = message.replace("bash", "").replace("run", "").strip()
        
        tool_events.append({
            "tool_name": "execute_bash",
            "status": "running",
            "input": {"command": cmd},
            "output": None
        })
        time.sleep(1.0)
        
        res = execute_bash(cmd)
        if "error" in res:
            tool_events[-1]["status"] = "error"
        else:
            tool_events[-1]["status"] = "success"
        tool_events[-1]["output"] = res
        final_content = f"Executed: `{cmd}`"

    elif "stats" in msg_lower:
        # Mocking Stats display
        final_content = "Here are your usage statistics for the last 24 hours:\n- Requests: 42\n- Logic Accuracy: 96%\n- Tokens: 12.5k"

    elif "deep" in msg_lower or "think" in msg_lower or "思考" in msg_lower:
        # DeepSeek Simulation
        final_content = "Based on my deep reasoning, the solution involves quantum entanglement principles..."
        
        tool_events.append({
            "tool_name": "deep_think",
            "status": "running",
            "input": {"prompt": message},
            "output": None
        })
        time.sleep(2) # Simulate thinking
        
        tool_events[-1]["status"] = "success"
        tool_events[-1]["output"] = {
            "reasoning_trace": "1. Analyze query\n2. Retrieve physics constants\n3. Calculate entropy...",
            "conclusion": "The answer is 42."
        }
    
    else:
        # General Chat
        final_content = f"I received your message: '{message}'. Try asking me to 'organize literature' or use 'deep thinking'."

    return {
        "content": final_content,
        "tool_events": tool_events
    }
