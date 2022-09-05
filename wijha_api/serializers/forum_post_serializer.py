from rest_framework_mongoengine import serializers
from wijha_api.models.forum_post import ForumPost


class ForumPostSerializer(serializers.DocumentSerializer):
    class Meta:
        model = ForumPost
        depth = 2
        fields = ["id", "title", "content", "likes", "author", "tags", "parent_post", "subforum"]
        # fields = "__all__"

        # extra_kwargs = {
        #     "author": {"read_only": False},
        #     "tags": {"read_only": False},
        #     "parent_post": {"read_only": False},
        #     "subforum": {"read_only": False},
        #     "id": {"read_only": False},
        # }
