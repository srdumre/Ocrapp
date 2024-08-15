from rest_framework import serializers
from .models import RecognizedText

class RecognizedTextSerializer(serializers.ModelSerializer):
    file = serializers.SerializerMethodField()

    class Meta:
        model = RecognizedText
        fields = ['id', 'created_at', 'file']  # 'file_url' has been replaced with 'file'

    def get_file(self, obj):
        request = self.context.get('request')
        if request and obj.file:
            return request.build_absolute_uri(obj.file.url)
        return None
