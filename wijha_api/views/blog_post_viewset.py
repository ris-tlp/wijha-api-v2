from rest_framework_mongoengine import viewsets
from rest_framework.parsers import JSONParser
from rest_framework.response import Response
from rest_framework import mixins
from rest_framework import status
from mongoengine import ValidationError
import io


from wijha_api.serializers.blog_post_serializer import BlogPostSerializer
from wijha_api.models.blog_post import BlogPost


class BlogPostViewSet(
    mixins.CreateModelMixin,
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet,
):
    """
    Implements List, Create and Retrieve endpoints
    """

    serializer_class = BlogPostSerializer
    queryset = BlogPost.objects.all()
    lookup_field = "title"
    parser_classes = [JSONParser]

    def create(self, request, *args, **kwargs):
        serializer = BlogPostSerializer(data=request.data)

        if serializer.is_valid():
            try:
                BlogPost(**serializer.validated_data).save()
                return Response(status=status.HTTP_201_CREATED)
            except ValidationError:
                return Response(status=status.HTTP_406_NOT_ACCEPTABLE)
        else:
            return Response(status=status.HTTP_406_NOT_ACCEPTABLE)
