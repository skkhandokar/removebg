from django.urls import path
from .views import RemoveBackgroundView

urlpatterns = [
    path('remove-bg/', RemoveBackgroundView.as_view(), name='remove-bg'),
]