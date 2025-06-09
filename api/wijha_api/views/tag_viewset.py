from rest_framework_mongoengine import viewsets
from rest_framework.response import Response
from rest_framework import mixins

from wijha_api.serializers.tag_serializer import TagSerializer
from wijha_api.models.tag import Tag


class TagViewSet(
    mixins.CreateModelMixin,
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet,
):
    """
    Implements List, Create and Retrieve endpoints
    """

    serializer_class = TagSerializer
    queryset = Tag.objects.all()
    lookup_field = "title"
