from rest_framework_mongoengine import serializers
from wijha_api.models.blog_post import BlogPost


class BlogPostSerializer(serializers.DocumentSerializer):
    class Meta:
        model = BlogPost
        depth = 2
        fields = [
            "id",
            "title",
            "content",
            "likes",
            "author",
            "tags",
            "published_status",
            "image_url",
        ]
        # fields = "__all__"

        # extra_kwargs = {
        #     "author": {"read_only": False},
        #     "tags": {"read_only": False},
        #     "parent_post": {"read_only": False},
        #     "subforum": {"read_only": False},
        #     "id": {"read_only": False},
        # }
