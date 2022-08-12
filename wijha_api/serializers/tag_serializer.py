from rest_framework_mongoengine import serializers
from ..models.tag import Tag


class TagSerializer(serializers.DocumentSerializer):
    class Meta:
        model = Tag
        fields = ["id", "title", "icon"]
