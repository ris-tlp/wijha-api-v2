from rest_framework_mongoengine import viewsets
from rest_framework.response import Response
from rest_framework import mixins

from ..serializers.tag_serializer import TagSerializer
from ..models.tag import Tag


class TagViewSet(
    mixins.CreateModelMixin,
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet,
):
    """
    Implements List, Create and Retrieve endpoints
    List [GET]: /tag/
    Retrieve [GET]: /tag/<title>
    Create [POST]: /tag/
    """

    serializer_class = TagSerializer
    queryset = Tag.objects.all()
    lookup_field = "title"
