from rest_framework_mongoengine import serializers
from wijha_api.models.user import *


class UserSerializer(serializers.DocumentSerializer):
    class Meta:
        model = User
        fields = ["id", "username", "password", "profile_picture", "travel_points", "user_type"]

        # extra_kwargs = {"id": {"read_only": False}}
