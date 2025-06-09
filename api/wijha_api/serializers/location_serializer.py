from rest_framework_mongoengine import serializers
from wijha_api.models.location import Location


class LocationSerializer(serializers.DocumentSerializer):
    class Meta:
        model = Location
        depth = 2
        fields = ["id", "name", "description", "image_url", "province"]
