import io
from PIL import Image
from rembg import remove, new_session  # new_session ইমপোর্ট করুন
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.http import HttpResponse

# হালকা মডেলের জন্য গ্লোবাল সেশন তৈরি (u2netp মডেলটি মেমরি অনেক কম নেয়)
session = new_session("u2netp")

class RemoveBackgroundView(APIView):
    def post(self, request, *args, **kwargs):
        if 'image' not in request.FILES:
            return Response({"error": "No image uploaded"}, status=status.HTTP_400_BAD_REQUEST)
        
        uploaded_file = request.FILES['image']
        
        try:
            input_image = Image.open(uploaded_file)
            
            # session=session প্যারামিটারটি দিয়ে কম মেমরির মডেল ব্যবহার নিশ্চিত করা হলো
            output_image = remove(input_image, session=session)
            
            img_byte_arr = io.BytesIO()
            output_image.save(img_byte_arr, format='PNG')
            
            response = HttpResponse(img_byte_arr.getvalue(), content_type="image/png")
            response['Content-Disposition'] = 'inline; filename="cutout.png"'
            return response

        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)