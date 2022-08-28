from rest_framework_mongoengine import serializers
from wijha_api.models.forum_post import ForumPost


class ForumPostSerializer(serializers.DocumentSerializer):
    class Meta:
        model = ForumPost
        depth = 3
        fields = ["id", "title", "content", "likes", "author", "tags", "parent_post", "subforum"]
