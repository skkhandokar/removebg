from django.urls import path
from .views import PdfConvertView

urlpatterns = [
    path('convert/', PdfConvertView.as_view(), name='pdf-convert'),
]