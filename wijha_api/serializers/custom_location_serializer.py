from rest_framework_mongoengine import serializers
from wijha_api.models.custom_location import CustomLocation


class CustomLocationSerializer(serializers.DocumentSerializer):
    class Meta:
        model = CustomLocation
        depth = 2
        fields = [
            "id",
            "name",
            "description",
            "location_fact",
            "location_number",
            "image_url",
            "guide",
            "coordinates_latitude",
            "coordinates_longitude",
        ]
