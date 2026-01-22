from django.shortcuts import render
from django.conf import settings
from django.http import JsonResponse
from django.views.decorators.csrf import ensure_csrf_cookie, csrf_exempt
import json
from core.engine import run_agent, save_api_config

@ensure_csrf_cookie
def index(request):
    # Default to the parent of the openresearch directory, which is the repository root
    workspace_dir = settings.BASE_DIR.parent
    return render(request, 'web/index.html', {
        'workspace_dir': str(workspace_dir),
        'server_url': 'http://127.0.0.1:4096'
    })

def chat_api(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        user_message = data.get('message')
        
        # Run Agent Logic
        response_data = run_agent(user_message)
        
        return JsonResponse(response_data)
    return JsonResponse({'error': 'Method not allowed'}, status=405)

def config_api(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        configs = data.get('configs', [])
        save_api_config(configs)
        return JsonResponse({'status': 'ok'})
    return JsonResponse({'error': 'Method not allowed'}, status=405)

@csrf_exempt
def delete_session_proxy(request, session_id):
    if request.method in ['DELETE', 'POST']:
        import requests
        server_url = 'http://127.0.0.1:4096'
        workspace_dir = settings.BASE_DIR.parent
        
        print(f"[Proxy] Deleting session {session_id} on backend...")
        try:
            target_url = f"{server_url}/session/{session_id}?directory={workspace_dir}"
            resp = requests.delete(target_url)
            print(f"[Proxy] Backend returned {resp.status_code}")
            return JsonResponse({'status': 'ok', 'backend_code': resp.status_code}, status=resp.status_code)
        except Exception as e:
            print(f"[Proxy] Error: {str(e)}")
            return JsonResponse({'error': str(e)}, status=500)
    return JsonResponse({'error': 'Method not allowed'}, status=405)
