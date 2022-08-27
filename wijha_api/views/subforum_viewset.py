from rest_framework_mongoengine import viewsets
from rest_framework.response import Response
from rest_framework import mixins

from wijha_api.serializers.subforum_serializer import SubforumSerializer
from wijha_api.models.subforum import Subforum


class SubforumViewSet(
    mixins.CreateModelMixin,
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet,
):
    """
    Implements List, Create and Retrieve endpoints
    """

    serializer_class = SubforumSerializer
    queryset = Subforum.objects.all()
    lookup_field = "title"
