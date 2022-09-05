from rest_framework_mongoengine import serializers
from wijha_api.models.subforum import Subforum


class SubforumSerializer(serializers.DocumentSerializer):
    class Meta:
        model = Subforum
        fields = ["id", "title", "description", "icon", "total_posts"]

        # extra_kwargs = {"id": {"read_only": False}}
