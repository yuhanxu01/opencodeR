from django.db import models
import os

class LiteratureFile(models.Model):
    CATEGORY_CHOICES = [
        ('math', 'Mathematics'),
        ('physics', 'Physics'),
        ('cs', 'Computer Science'),
        ('engineering', 'Engineering'),
        ('textbooks', 'Textbooks'),
        ('uncategorized', 'Uncategorized'),
    ]

    file = models.FileField(upload_to='') # Uploads go directly to MEDIA_ROOT (files/)
    original_name = models.CharField(max_length=255)
    category = models.CharField(max_length=50, choices=CATEGORY_CHOICES, default='uncategorized')
    upload_date = models.DateTimeField(auto_now_add=True)
    processed = models.BooleanField(default=False)
    content_summary = models.TextField(blank=True, null=True)

    def save(self, *args, **kwargs):
        if not self.original_name and self.file:
            self.original_name = os.path.basename(self.file.name)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.original_name
