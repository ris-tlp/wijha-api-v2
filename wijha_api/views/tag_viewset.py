from rest_framework_mongoengine import viewsets
from ..models.tag import Tag
from ..serializers.tag_serializer import TagSerializer


class TagViewSet(viewsets.ModelViewSet):
    lookup_field = "_id"
    serializer_class = TagSerializer

    def get_queryset(self):
        return Tag.objects.all()
