import os
import shutil
from django.conf import settings
from knowledge.models import LiteratureFile

def scan_uploaded_files(session_id=None):
    """
    Scans the uploads folder (MEDIA_ROOT) for new files and registers them in DB if not exists.
    Returns list of files found.
    """
    upload_dir = settings.MEDIA_ROOT
    files_found = []
    
    if not os.path.exists(upload_dir):
        return []

    for filename in os.listdir(upload_dir):
        file_path = os.path.join(upload_dir, filename)
        if os.path.isfile(file_path):
            files_found.append(filename)
            # Sync with DB
            if not LiteratureFile.objects.filter(original_name=filename).exists():
                LiteratureFile.objects.create(original_name=filename, file=filename)
    
    return files_found

def categorize_literature(filename):
    """
    Reads the file and determines category based on keywords.
    """
    upload_dir = settings.MEDIA_ROOT
    file_path = os.path.join(upload_dir, filename)
    
    if not os.path.exists(file_path):
        return {"error": "File not found"}

    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read(1000) # Read first 1000 chars
    except UnicodeDecodeError:
         return {"error": "Could not read file (encoding)"}

    content_lower = content.lower()
    
    # Keywords
    scores = {
        'math': ['theorem', 'proof', 'matrix', 'vector', '定理', '证明', '矩阵'],
        'physics': ['quantum', 'energy', 'wave', 'thermodynamics', '量子', '能量'],
        'cs': ['algorithm', 'complexity', 'data', 'code', '算法', '复杂度'],
    }
    
    best_cat = 'uncategorized'
    max_score = 0
    
    details = {}

    for cat, keywords in scores.items():
        count = sum(1 for k in keywords if k in content_lower)
        details[cat] = count
        if count > max_score:
            max_score = count
            best_cat = cat
            
    return {
        "category": best_cat,
        "confidence": "high" if max_score > 2 else "low",
        "scores": details
    }

def move_file(filename, target_category):
    """
    Moves file to .opencode/literature/<category>/
    """
    # Mapping
    category_map = {
        'math': 'math',
        'physics': 'physics',
        'cs': 'cs',
        'engineering': 'engineering',
        'textbooks': 'textbooks',
        'uncategorized': 'uncategorized'
    }
    
    subdir = category_map.get(target_category, 'uncategorized')
    
    # The organized directory is usually .opencode/literature/
    # We need to find where .opencode is.
    # settings.BASE_DIR = .../openresearch/
    # .opencode is in .../openresearch/../.opencode, i.e. opencode-research/.opencode
    
    root_dir = settings.BASE_DIR.parent
    target_dir = os.path.join(root_dir, '.opencode', 'literature', subdir)
    os.makedirs(target_dir, exist_ok=True)
    
    source_path = os.path.join(settings.MEDIA_ROOT, filename)
    target_path = os.path.join(target_dir, filename)
    
    if os.path.exists(source_path):
        shutil.move(source_path, target_path)
        
        # Update DB
        lf = LiteratureFile.objects.filter(original_name=filename).first()
        if lf:
            lf.category = target_category
            lf.processed = True
            lf.save()
            
        return {"status": "success", "new_path": target_path}
    else:
        return {"error": "Source file not found"}

# --- General Code Agent Tools ---

def _get_workspace_root():
    # Allow accessing the entire research project
    return settings.BASE_DIR.parent

def _is_within_workspace(path):
    root = _get_workspace_root()
    abs_path = os.path.abspath(os.path.join(root, path))
    return abs_path.startswith(str(root))

def list_files(rel_path="."):
    """Lists files in the workspace at the given relative path."""
    if not _is_within_workspace(rel_path):
        return {"error": "Access denied: Path outside workspace."}
    
    abs_path = os.path.join(_get_workspace_root(), rel_path)
    if not os.path.exists(abs_path):
        return {"error": "Path does not exist."}
    
    try:
        items = os.listdir(abs_path)
        result = []
        for item in items:
            full_item_path = os.path.join(abs_path, item)
            is_dir = os.path.isdir(full_item_path)
            result.append({
                "name": item,
                "type": "directory" if is_dir else "file",
                "size": os.path.getsize(full_item_path) if not is_dir else None
            })
        return {"files": result}
    except Exception as e:
        return {"error": str(e)}

def read_file(rel_path):
    """Reads the content of a file in the workspace."""
    if not _is_within_workspace(rel_path):
        return {"error": "Access denied."}
    
    abs_path = os.path.join(_get_workspace_root(), rel_path)
    if not os.path.isfile(abs_path):
        return {"error": "File not found."}
    
    try:
        with open(abs_path, 'r', encoding='utf-8') as f:
            content = f.read()
        return {"content": content}
    except Exception as e:
        return {"error": str(e)}

def edit_file(rel_path, content):
    """Writes or overwrites a file in the workspace."""
    if not _is_within_workspace(rel_path):
        return {"error": "Access denied."}
    
    abs_path = os.path.join(_get_workspace_root(), rel_path)
    os.makedirs(os.path.dirname(abs_path), exist_ok=True)
    
    try:
        with open(abs_path, 'w', encoding='utf-8') as f:
            f.write(content)
        return {"status": "success", "file": rel_path}
    except Exception as e:
        return {"error": str(e)}

def execute_bash(command):
    """Executes a bash command in the workspace root."""
    import subprocess
    
    root = _get_workspace_root()
    # Security: Basic check to prevent some obvious malicious commands
    # (Though in a local research environment, the user is the owner)
    forbidden = ["rm -rf /", "mkfs", "dd if="]
    if any(f in command for f in forbidden):
        return {"error": "Command contains forbidden patterns."}

    try:
        result = subprocess.run(
            command,
            shell=True,
            cwd=root,
            capture_output=True,
            text=True,
            timeout=30 # 30 second timeout
        )
        return {
            "stdout": result.stdout,
            "stderr": result.stderr,
            "exit_code": result.returncode
        }
    except subprocess.TimeoutExpired:
        return {"error": "Command timed out after 30 seconds."}
    except Exception as e:
        return {"error": str(e)}
