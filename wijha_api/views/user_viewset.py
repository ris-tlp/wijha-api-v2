from rest_framework_mongoengine import viewsets
from rest_framework.response import Response
from rest_framework import mixins
from rest_framework import status


from wijha_api.serializers.user_serializer import UserSerializer
from wijha_api.models.user import *
from wijha_api.utils.password_hashing import *


class UserViewSet(
    mixins.CreateModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet,
):
    """
    Implements Create and Retrieve endpoints
    """

    serializer_class = UserSerializer
    queryset = User.objects.all()
    lookup_field = "username"

    def create(self, request):
        """
        Creates a user with a hashed password from the form provided
        """
        try:
            User(
                username=request.data["username"],
                password=get_hashed_password(request.data["password"]),
                profile_picture=request.data["profile_picture"],
                travel_points=request.data["travel_points"],
                user_type=request.data["user_type"],
            ).save()

            return Response(status=status.HTTP_201_CREATED)
        except Exception as e:
            return Response(status=status.HTTP_406_NOT_ACCEPTABLE)
