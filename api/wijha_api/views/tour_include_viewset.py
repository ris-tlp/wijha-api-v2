from rest_framework_mongoengine import viewsets
from rest_framework.response import Response
from rest_framework import mixins

from wijha_api.serializers.tour_include_serializer import TourIncludeSerializer
from wijha_api.models.tour_include import TourInclude


class TourIncludeViewSet(
    mixins.CreateModelMixin,
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet,
):
    """
    Implements List, Create and Retrieve endpoints
    """

    serializer_class = TourIncludeSerializer
    queryset = TourInclude.objects.all()
    lookup_field = "title"
