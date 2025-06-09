from rest_framework_mongoengine import viewsets
from rest_framework.parsers import JSONParser
from rest_framework.response import Response
from rest_framework import mixins
from rest_framework import status
from mongoengine import ValidationError

from wijha_api.serializers.ordered_location_serializer import OrderedLocationSerializer
from wijha_api.models.ordered_location import OrderedLocation


class OrderedLocationViewSet(
    mixins.CreateModelMixin,
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet,
):
    """
    Implements List, Create and Retrieve endpoints
    """

    serializer_class = OrderedLocationSerializer
    queryset = OrderedLocation.objects.all()
    lookup_field = "name"
    parser_classes = [JSONParser]

    def create(self, request, *args, **kwargs):
        serializer = OrderedLocationSerializer(data=request.data)

        if serializer.is_valid():
            try:
                OrderedLocation(**serializer.validated_data).save()
                return Response(status=status.HTTP_201_CREATED)
            except ValidationError:
                return Response(status=status.HTTP_406_NOT_ACCEPTABLE)

        else:
            return Response(status=status.HTTP_406_NOT_ACCEPTABLE)
