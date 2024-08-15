from django.urls import path
from .views import SaveTextAsCSV, FetchCSVData, FetchAllCSVFiles

urlpatterns = [
    path('save-text-as-csv/', SaveTextAsCSV.as_view(), name='save_text_as_csv'),
    path('fetch-csv-data/<int:csv_id>/', FetchCSVData.as_view(), name='fetch_csv_data'),
    path('fetch-all-csv-files/', FetchAllCSVFiles.as_view(), name='fetch_all_csv_files'),
]
