from django.db import models

class APIConfiguration(models.Model):
    PROVIDER_CHOICES = [
        ('opencode', 'OpenCode (GLM)'),
        ('deepseek', 'DeepSeek'),
    ]
    provider_name = models.CharField(max_length=50, choices=PROVIDER_CHOICES, unique=True)
    api_key = models.CharField(max_length=255)
    base_url = models.URLField(blank=True, null=True)
    is_active = models.BooleanField(default=True)

    def __str__(self):
        return self.provider_name

class Conversation(models.Model):
    title = models.CharField(max_length=200, default="New Chat")
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title

class Message(models.Model):
    ROLE_CHOICES = [
        ('user', 'User'),
        ('assistant', 'Assistant'),
        ('system', 'System'),
    ]
    conversation = models.ForeignKey(Conversation, related_name='messages', on_delete=models.CASCADE)
    role = models.CharField(max_length=20, choices=ROLE_CHOICES)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.role} - {self.created_at}"

class ToolEvent(models.Model):
    STATUS_CHOICES = [
        ('running', 'Running'),
        ('success', 'Success'),
        ('error', 'Error'),
    ]
    message = models.ForeignKey(Message, related_name='tool_events', on_delete=models.CASCADE)
    tool_name = models.CharField(max_length=100)
    input_data = models.JSONField(default=dict)
    output_data = models.JSONField(default=dict, blank=True, null=True)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='running')
    started_at = models.DateTimeField(auto_now_add=True)
    completed_at = models.DateTimeField(null=True, blank=True)
    error_message = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"{self.tool_name} ({self.status})"

class UsageLog(models.Model):
    timestamp = models.DateTimeField(auto_now_add=True)
    provider = models.CharField(max_length=50)
    model_name = models.CharField(max_length=100)
    input_tokens = models.IntegerField(default=0)
    output_tokens = models.IntegerField(default=0)
    cost = models.DecimalField(max_digits=10, decimal_places=6, default=0)
    
    def __str__(self):
        return f"{self.provider} - {self.timestamp}"
