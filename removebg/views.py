import io
from PIL import Image
from rembg import remove
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.http import HttpResponse

class RemoveBackgroundView(APIView):
    def post(self, request, *args, **kwargs):
        if 'image' not in request.FILES:
            return Response({"error": "No image uploaded"}, status=status.HTTP_400_BAD_REQUEST)
        
        uploaded_file = request.FILES['image']
        
        try:
            input_image = Image.open(uploaded_file)
            output_image = remove(input_image)
            
            img_byte_arr = io.BytesIO()
            output_image.save(img_byte_arr, format='PNG')
            
            response = HttpResponse(img_byte_arr.getvalue(), content_type="image/png")
            response['Content-Disposition'] = 'inline; filename="cutout.png"'
            return response

        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)