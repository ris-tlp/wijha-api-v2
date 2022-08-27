from rest_framework_mongoengine import viewsets
from rest_framework.response import Response
from rest_framework import mixins

from wijha_api.serializers.forum_post_serializer import ForumPostSerializer
from wijha_api.models.forum_post import ForumPost


class ForumPostViewSet(
    mixins.CreateModelMixin,
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet,
):
    """
    Implements List, Create and Retrieve endpoints
    """

    serializer_class = ForumPostSerializer
    queryset = ForumPost.objects.all()
    lookup_field = "title"
