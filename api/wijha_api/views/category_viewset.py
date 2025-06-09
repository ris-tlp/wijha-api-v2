from rest_framework_mongoengine import viewsets
from rest_framework.response import Response
from rest_framework import mixins

from wijha_api.serializers.category_serializer import CategorySerializer
from wijha_api.models.category import Category


class CategoryViewSet(
    mixins.CreateModelMixin,
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet,
):
    """
    Implements List, Create and Retrieve endpoints
    """

    serializer_class = CategorySerializer
    queryset = Category.objects.all()
    lookup_field = "title"
