from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from .serializer import RecognizedTextSerializer
from .models import RecognizedText
import csv
from io import StringIO
from django.core.files.base import ContentFile
import uuid

class SaveTextAsCSV(APIView):
    def post(self, request, *args, **kwargs):
        try:
            recognized_text = request.data.get('recognized_text', '')

            if not recognized_text:
                return Response({'error': 'No recognized text provided'}, status=status.HTTP_400_BAD_REQUEST)
            
            csv_model = self.save_recognized_text_as_csv(recognized_text)
            serializer = RecognizedTextSerializer(csv_model)
            return Response(serializer.data, status=status.HTTP_201_CREATED)

        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_400_BAD_REQUEST)

    def save_recognized_text_as_csv(self, text, file_name=None):
        try:
            csv_content = StringIO()
            writer = csv.writer(csv_content)
            lines = text.splitlines()
            for line in lines:
                writer.writerow([line])

            if not file_name:
                file_name = f"{uuid.uuid4()}.csv"

            csv_file = ContentFile(csv_content.getvalue())
            csv_model = RecognizedText()
            csv_model.file.save(file_name, csv_file)
            csv_model.save()

            return csv_model
        
        except Exception as e:
            raise Exception(f"Error saving CSV: {str(e)}")

class FetchCSVData(APIView):
    def get(self, request, csv_id, *args, **kwargs):
        try:
            csv_model = RecognizedText.objects.get(id=csv_id)
        
            serializer = RecognizedTextSerializer(csv_model)
            
            return Response(serializer.data, status=status.HTTP_200_OK)

        except RecognizedText.DoesNotExist:
            return Response({'error': 'CSV file not found'}, status=status.HTTP_404_NOT_FOUND)

        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class FetchAllCSVFiles(APIView):
    def get(self, request, *args, **kwargs):
        try:
            csv_files = RecognizedText.objects.all()
            serializer = RecognizedTextSerializer(csv_files, many=True, context={'request': request})
            return Response(serializer.data, status=status.HTTP_200_OK)
        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_400_BAD_REQUEST)