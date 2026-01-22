// Constants
const SERVER_URL = window.SERVER_URL || 'http://127.0.0.1:4096';
const WORKSPACE_DIR = window.WORKSPACE_DIR || '/Users/renqing/Downloads/opencode-research';

// Configure Marked
if (window.marked) {
    marked.setOptions({
        headerIds: false,
        mangle: false,
        breaks: true,
        gfm: true
    });
}

// DOM Elements
const chatContainer = document.getElementById('chatContainer');
const userInput = document.getElementById('userInput');
const settingsModal = document.getElementById('settingsModal');
const historyList = document.getElementById('historyList');
const welcomeScreen = document.getElementById('welcomeScreen');
const rightSidebar = document.getElementById('rightSidebar');
const planProgress = document.getElementById('planProgress');

// State
let currentSessionID = null;
let lastRenderedState = "";
let isBusy = false;
let isDeleting = false;
let pendingPermissions = new Set();

// Toast notification system
function showToast(message, type = 'info') {
    const toast = document.createElement('div');
    toast.className = `toast toast-${type}`;
    toast.textContent = message;
    document.body.appendChild(toast);

    setTimeout(() => toast.classList.add('show'), 10);
    setTimeout(() => {
        toast.classList.remove('show');
        setTimeout(() => toast.remove(), 300);
    }, 3000);
}

// Initialization
async function init() {
    await loadSessions();
    setupSSE();
    userInput?.focus();

    // Restore last session from localStorage
    const lastSession = localStorage.getItem('lastSessionID');
    if (lastSession) {
        loadSessionChat(lastSession);
    }
}

// UI Handlers
function openSettings() { settingsModal.style.display = 'flex'; }
function closeSettings() { settingsModal.style.display = 'none'; }
async function newChat() {
    await createSession();
    welcomeScreen.style.display = 'flex';
    rightSidebar.style.display = 'none';
}

function toggleSelectionMode() {
    const historyList = document.getElementById('historyList');
    const btn = document.querySelector('.header-action-btn');
    const isMode = historyList.classList.toggle('selection-mode');
    btn.classList.toggle('active', isMode);

    // If exiting selection mode, uncheck all
    if (!isMode) {
        document.querySelectorAll('.session-checkbox').forEach(cb => cb.checked = false);
        updateBatchUI();
    }
}

// Global flag for any interactive operation that shouldn't be interrupted
let isInteracting = false;

// SSE for Real-time Events
let evtSource;
function setupSSE() {
    if (evtSource) evtSource.close();
    const url = new URL(`${SERVER_URL}/event`);
    url.searchParams.set('directory', WORKSPACE_DIR);
    evtSource = new EventSource(url.href);
    evtSource.onmessage = (e) => {
        try {
            const event = JSON.parse(e.data);
            handleServerEvent(event);
        } catch (err) { }
    };
    evtSource.onerror = () => setTimeout(setupSSE, 3000);
}

function handleServerEvent(event) {
    const sessionID = event.properties?.sessionID || event.sessionID;

    if (event.type === 'session.updated' && !isDeleting && !isInteracting) loadSessions();

    if (sessionID === currentSessionID) {
        if (event.type === 'session.status') updateBusyStatus(event.status.type === 'busy');

        if (event.type === 'permission.asked') {
            pendingPermissions.add(event.id);
            loadSessionChat(currentSessionID);
        }

        if (event.type === 'permission.replied') {
            pendingPermissions.delete(event.requestID);
            loadSessionChat(currentSessionID);
        }

        if (event.type?.includes('message') || event.type?.includes('part')) {
            loadSessionChat(currentSessionID);
        }
    }
}

function updateBusyStatus(busy) {
    isBusy = busy;
    const existing = document.getElementById('working-indicator');
    if (busy) {
        if (!existing) {
            const indicator = document.createElement('div');
            indicator.id = 'working-indicator';
            indicator.className = 'message assistant';
            indicator.innerHTML = `<div class="working-content"><span class="pulse-dot"></span><span>Working...</span></div>`;
            chatContainer.appendChild(indicator);
            smoothScrollToBottom();
        }
    } else { existing?.remove(); }
}

async function loadSessions() {
    try {
        const url = new URL(`${SERVER_URL}/session`);
        url.searchParams.set('directory', WORKSPACE_DIR);
        const res = await fetch(url.href);
        const sessions = await res.json();

        historyList.innerHTML = '';

        // Batch Action Header
        if (sessions.length > 0) {
            const batchContainer = document.createElement('div');
            batchContainer.className = 'batch-actions';
            batchContainer.id = 'batchActions';
            batchContainer.innerHTML = `
                <span id="selectedCount">0 selected</span>
                <button class="delete-selected-btn" onclick="deleteSelectedSessions()">Delete Selected</button>
            `;
            historyList.appendChild(batchContainer);
        }

        sessions.forEach(sess => {
            const container = document.createElement('div');
            container.className = 'history-item-wrapper' + (sess.id === currentSessionID ? ' active' : '');

            const checkbox = document.createElement('input');
            checkbox.type = 'checkbox';
            checkbox.className = 'session-checkbox';
            checkbox.value = sess.id;
            checkbox.onclick = (e) => {
                e.stopPropagation();
                updateBatchUI();
            };

            const div = document.createElement('div');
            div.className = 'history-item-content';
            div.textContent = sess.title || "Untitled Chat";
            div.onclick = () => loadSessionChat(sess.id);

            const deleteBtn = document.createElement('button');
            deleteBtn.className = 'history-delete-btn';
            deleteBtn.innerHTML = `
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M3 6h18M19 6v14a2 2 0 01-2 2H7a2 2 0 01-2-2V6m3 0V4a2 2 0 012-2h4a2 2 0 012 2v2M10 11v6M14 11v6"/>
                </svg>
            `;
            deleteBtn.onclick = (e) => {
                e.stopPropagation();
                e.preventDefault();
                const sessionID = sess.id;
                console.log(`[UI] Delete clicked for ${sessionID}`);
                if (window.confirm('Delete this conversation?')) {
                    deleteSession(sessionID);
                }
            };

            container.appendChild(checkbox);
            container.appendChild(div);
            container.appendChild(deleteBtn);
            historyList.appendChild(container);
        });
    } catch (e) { }
}

function updateBatchUI() {
    const checkboxes = document.querySelectorAll('.session-checkbox:checked');
    const batchActions = document.getElementById('batchActions');
    const selectedCount = document.getElementById('selectedCount');

    if (checkboxes.length > 0) {
        selectedCount.textContent = `${checkboxes.length} selected`;
    } else if (selectedCount) {
        selectedCount.textContent = `0 selected`;
    }
}

async function deleteSession(sessionID, skipReload = false) {
    if (!sessionID) return;
    const oldDeleting = isDeleting;
    isDeleting = true;
    try {
        // Use relative path to hit Django proxy endpoint
        const url = `/api/session/${sessionID}/`;
        console.log(`[Fetch] DELETE to ${url}`);

        const res = await fetch(url, {
            method: 'DELETE',
            cache: 'no-cache',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        if (!res.ok) {
            const errText = await res.text();
            throw new Error(`Failed to delete session: ${res.status} - ${errText}`);
        }

        console.log(`[Success] Session ${sessionID} deleted`);

        if (sessionID === currentSessionID) {
            currentSessionID = null;
            localStorage.removeItem('lastSessionID');
            chatContainer.innerHTML = '';
            welcomeScreen.style.display = 'flex';
            const rs = document.getElementById('rightSidebar');
            if (rs) rs.style.display = 'none';
            lastRenderedState = "";
        }
        if (!skipReload) await loadSessions();
        return true;
    } catch (e) {
        console.error('Delete failed:', e);
        if (!skipReload) {
            showToast('Failed to delete session: ' + e.message, 'error');
        }
        throw e;
    } finally {
        isDeleting = oldDeleting;
    }
}

async function deleteSelectedSessions() {
    const checkboxes = document.querySelectorAll('.session-checkbox:checked');
    if (checkboxes.length === 0) {
        showToast('Please select at least one conversation', 'warning');
        return;
    }

    if (confirm(`Delete ${checkboxes.length} selected conversation${checkboxes.length > 1 ? 's' : ''}?`)) {
        isDeleting = true;
        const ids = Array.from(checkboxes).map(cb => cb.value);
        let failCount = 0;
        let successCount = 0;

        showToast(`Deleting ${ids.length} conversation${ids.length > 1 ? 's' : ''}...`, 'info');

        try {
            for (let i = 0; i < ids.length; i++) {
                try {
                    await deleteSession(ids[i], true); // true means skip individual reloads
                    successCount++;
                } catch (err) {
                    failCount++;
                }
            }
        } finally {
            isDeleting = false;
            await loadSessions(); // One final reload
            toggleSelectionMode(); // Exit selection mode

            if (failCount > 0) {
                showToast(`Deleted ${successCount} conversation(s), ${failCount} failed`, 'warning');
            } else {
                showToast(`Successfully deleted ${successCount} conversation(s)`, 'success');
            }
        }
    }
}

async function createSession() {
    try {
        const url = new URL(`${SERVER_URL}/session`);
        url.searchParams.set('directory', WORKSPACE_DIR);
        const res = await fetch(url.href, { method: 'POST' });

        if (!res.ok) {
            throw new Error(`Failed to create session: ${res.status}`);
        }

        const sess = await res.json();
        currentSessionID = sess.id;
        localStorage.setItem('lastSessionID', sess.id);
        chatContainer.innerHTML = '';
        welcomeScreen.style.display = 'flex';
        rightSidebar.style.display = 'none';
        await loadSessions();
        showToast('New conversation created', 'success');
    } catch (e) {
        console.error('Failed to create session:', e);
        showToast('Failed to create new conversation', 'error');
    }
}

async function loadSessionChat(sessionID) {
    if (!sessionID) return;
    currentSessionID = sessionID;
    localStorage.setItem('lastSessionID', sessionID);
    welcomeScreen.style.display = 'none';

    try {
        const url = new URL(`${SERVER_URL}/session/${sessionID}/message`);
        url.searchParams.set('directory', WORKSPACE_DIR);
        const res = await fetch(url.href);
        const messages = await res.json();

        const currentState = JSON.stringify({ messages, pending: Array.from(pendingPermissions) });
        if (currentState === lastRenderedState) return;
        lastRenderedState = currentState;

        const working = document.getElementById('working-indicator');
        chatContainer.innerHTML = '';

        let hasTasks = false;
        let tasks = [];

        messages.forEach(msg => {
            renderFullMessage(msg);
            // Collect tasks for right sidebar
            msg.parts.forEach(p => {
                if (p.type === 'tool' && p.state.metadata?.summary) {
                    tasks = p.state.metadata.summary;
                    hasTasks = true;
                }
            });
        });

        // Update Right Sidebar
        if (hasTasks) {
            rightSidebar.style.display = 'flex';
            renderPlanProgress(tasks);
        } else {
            rightSidebar.style.display = 'none';
        }

        // Show pending permissions as cards if not already in conversation
        await renderPendingApprovals();

        if (working) chatContainer.appendChild(working);
        smoothScrollToBottom();
    } catch (e) { }
}

async function renderPendingApprovals() {
    const url = new URL(`${SERVER_URL}/permission`);
    url.searchParams.set('directory', WORKSPACE_DIR);
    const res = await fetch(url.href);
    const pending = await res.json();

    pending.forEach(req => {
        if (req.sessionID !== currentSessionID) return;
        const card = document.createElement('div');
        card.className = 'approval-card';
        card.innerHTML = `
            <div class="approval-header">
                <div class="status-dot running"></div>
                <div class="approval-title">Permission Required: ${req.permission}</div>
            </div>
            <div style="font-size: 0.85rem; color: var(--text-secondary); margin-bottom: 20px;">
                The assistant wants to use <strong>${req.permission}</strong> on <strong>${req.patterns.join(', ')}</strong>.
            </div>
            <div class="approval-actions">
                <button class="btn-reject" onclick="replyPermission('${req.id}', 'reject')">Reject</button>
                <button class="btn-approve" onclick="replyPermission('${req.id}', 'once')">Approve</button>
            </div>
        `;
        chatContainer.appendChild(card);
    });
}

async function replyPermission(requestID, reply) {
    try {
        const url = new URL(`${SERVER_URL}/permission/${requestID}/reply`);
        url.searchParams.set('directory', WORKSPACE_DIR);
        await fetch(url.href, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ reply })
        });
        pendingPermissions.delete(requestID);
        loadSessionChat(currentSessionID);
    } catch (e) { alert(e.message); }
}

function renderPlanProgress(tasks) {
    planProgress.innerHTML = '';
    if (tasks.length === 0) {
        planProgress.innerHTML = '<div class="empty-state">No tasks identified yet</div>';
        return;
    }
    tasks.forEach(task => {
        const div = document.createElement('div');
        const isDone = task.state.status === 'completed';
        div.className = `plan-item ${isDone ? 'completed' : ''}`;
        div.innerHTML = `
            <div class="plan-checkbox"></div>
            <div class="plan-text">
                <div style="font-weight: 500;">${task.tool}</div>
                <div style="font-size: 0.75rem; color: var(--text-secondary);">${task.state.title || task.state.status}</div>
            </div>
        `;
        planProgress.appendChild(div);
    });
}

async function sendMessage() {
    const text = userInput.value.trim();
    if (!text || isBusy) return;
    if (!currentSessionID) await createSession();

    // Immediately show user message and working indicator for instant feedback
    welcomeScreen.style.display = 'none';
    appendUserMessage(text);
    updateBusyStatus(true);

    userInput.value = '';
    userInput.style.height = '24px';

    try {
        const url = new URL(`${SERVER_URL}/session/${currentSessionID}/prompt_async`);
        url.searchParams.set('directory', WORKSPACE_DIR);
        const response = await fetch(url.href, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ parts: [{ type: 'text', text: text }] })
        });

        if (!response.ok) {
            updateBusyStatus(false);
            const errorText = await response.text();
            showToast(`Request failed: ${response.status} - ${errorText}`, 'error');
        }
        // Note: SSE events will handle updating the UI with the response
    } catch (e) {
        updateBusyStatus(false);
        showToast(`Failed to send message: ${e.message}`, 'error');
        console.error('Send message error:', e);
    }
}

// Helper function to immediately show user's message
function appendUserMessage(text) {
    const messageDiv = document.createElement('div');
    messageDiv.className = 'message user';
    const textNode = document.createElement('div');
    textNode.className = 'text-content';
    textNode.innerHTML = window.marked ? marked.parse(text) : text;
    messageDiv.appendChild(textNode);
    chatContainer.appendChild(messageDiv);
    smoothScrollToBottom();
}

// Smooth scroll to bottom
function smoothScrollToBottom() {
    chatContainer.scrollTo({
        top: chatContainer.scrollHeight,
        behavior: 'smooth'
    });
}

function renderFullMessage(msgObj) {
    const role = msgObj.info.role;
    const messageDiv = document.createElement('div');
    messageDiv.className = `message ${role}`;
    msgObj.parts.forEach(part => {
        if (part.type === 'text') {
            const textNode = document.createElement('div');
            textNode.className = 'text-content';
            textNode.innerHTML = window.marked ? marked.parse(part.text) : part.text;
            messageDiv.appendChild(textNode);
        } else if (part.type === 'tool') {
            const toolBlock = document.createElement('div');
            toolBlock.className = 'tool-block';
            const s = part.state;
            const statusClass = s.status === 'error' ? 'error' : (s.status === 'completed' ? 'success' : 'running');

            let label = part.tool;
            const input = s.input || {};
            if (input.filePath) label += `: ${input.filePath.split('/').pop()}`;
            else if (input.path) label += `: ${input.path.split('/').pop()}`;
            else if (input.command) label += `: ${input.command.split(' ')[0]}...`;

            toolBlock.innerHTML = `
                <div class="tool-header" onclick="this.parentElement.classList.toggle('expanded')">
                    <span class="status-dot ${statusClass}"></span>
                    <span class="tool-name">${label}</span>
                    <svg class="chevron" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                </div>
                <div class="tool-details">
                    <div class="detail-label">Arguments</div>
                    <pre>${JSON.stringify(input, null, 2)}</pre>
                    ${s.output ? `<div class="detail-label">Output</div><pre>${typeof s.output === 'string' ? s.output : JSON.stringify(s.output, null, 2)}</pre>` : ''}
                    ${s.error ? `<div class="detail-label error">Error</div><pre class="error-text">${s.error}</pre>` : ''}
                </div>
            `;
            messageDiv.appendChild(toolBlock);
        }
    });
    chatContainer.appendChild(messageDiv);
}

// Global exposure
window.newChat = newChat;
window.sendMessage = sendMessage;
window.replyPermission = replyPermission;
window.openSettings = openSettings;
window.closeSettings = closeSettings;
window.deleteSession = deleteSession;
window.deleteSelectedSessions = deleteSelectedSessions;
window.toggleSelectionMode = toggleSelectionMode;

// Input handling
userInput?.addEventListener('keydown', (e) => {
    if (e.key === 'Enter' && !e.shiftKey) {
        e.preventDefault();
        sendMessage();
    }
});

userInput?.addEventListener('input', () => {
    const sendBtn = document.querySelector('.send-btn');
    if (sendBtn) {
        sendBtn.disabled = isBusy || !userInput.value.trim();
    }
});

document.getElementById('apiConfigForm')?.addEventListener('submit', async (e) => {
    e.preventDefault();
    const deepseekKey = document.getElementById('deepseekKey').value;

    if (!deepseekKey || !deepseekKey.startsWith('sk-')) {
        showToast('Please enter a valid API key (starts with sk-)', 'warning');
        return;
    }

    try {
        const url = new URL(`${SERVER_URL}/auth/deepseek`);
        url.searchParams.set('directory', WORKSPACE_DIR);
        const res = await fetch(url.href, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ key: deepseekKey })
        });

        if (!res.ok) {
            throw new Error(`Failed to save API key: ${res.status}`);
        }

        showToast("API key saved successfully!", 'success');
        closeSettings();
    } catch (e) {
        showToast(`Failed to save API key: ${e.message}`, 'error');
        console.error('API config error:', e);
    }
});

init();
