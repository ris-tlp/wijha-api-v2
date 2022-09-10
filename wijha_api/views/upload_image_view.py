import base64
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
import os

from wijha_api.utils.upload_file import upload_file


@api_view(["POST"])
def upload_image(request):
    BUCKET_NAME = os.environ.get("S3_BUCKET_NAME")

    try:
        result = upload_file(
            image_data=request.data["image"],
            bucket=BUCKET_NAME,
            file_name=request.data["file_name"],
        )
        if result["status"]:
            return Response(status=status.HTTP_201_CREATED, data={"image_url": result["image_url"]})
        else:
            return Response(status=status.HTTP_406_NOT_ACCEPTABLE)
    except Exception as e:
        return Response(status=status.HTTP_406_NOT_ACCEPTABLE)
