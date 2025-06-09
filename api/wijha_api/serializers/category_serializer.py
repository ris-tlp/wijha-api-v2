from rest_framework_mongoengine import serializers
from wijha_api.models.category import Category


class CategorySerializer(serializers.DocumentSerializer):
    class Meta:
        model = Category
        fields = ["id", "title", "icon"]

        # extra_kwargs = {"id": {"read_only": False}}
