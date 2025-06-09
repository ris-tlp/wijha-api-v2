from rest_framework_mongoengine import serializers
from wijha_api.models.ordered_location import OrderedLocation


class OrderedLocationSerializer(serializers.DocumentSerializer):
    class Meta:
        model = OrderedLocation
        depth = 2
        fields = [
            "id",
            "name",
            "description",
            "location_fact",
            "location_number",
            "image_url",
            "tour",
        ]

        # extra_kwargs = {"id": {"read_only": False}}
