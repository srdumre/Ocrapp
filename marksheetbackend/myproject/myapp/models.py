# models.py
from django.db import models
import uuid

class RecognizedText(models.Model):
    file = models.FileField(upload_to='recognized_text_csv/')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"CSV {self.id} - {self.created_at}"

    def save(self, *args, **kwargs):
        if not self.file.name:
            self.file.name = f"{uuid.uuid4()}.csv"
        super().save(*args, **kwargs)
