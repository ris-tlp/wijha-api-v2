from rest_framework_mongoengine import serializers
from wijha_api.models.tour import Tour


class TourSerializer(serializers.DocumentSerializer):
    class Meta:
        model = Tour
        depth = 2
        # fields = "__all__"
        fields = [
            "id",
            "title",
            "description",
            "capacity",
            "price",
            "active",
            "history",
            "date",
            "guide",
            "province",
            "images",
            "categories",
            "locations",
            "included",
            "rating",
        ]
