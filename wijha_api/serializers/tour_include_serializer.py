from rest_framework_mongoengine import serializers
from wijha_api.models.tour_include import TourInclude


class TourIncludeSerializer(serializers.DocumentSerializer):
    class Meta:
        model = TourInclude
        fields = ["id", "title", "icon"]
