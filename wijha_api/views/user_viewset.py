from os import stat
from urllib import response
from rest_framework_mongoengine import viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from mongoengine import DoesNotExist
from rest_framework import mixins
from rest_framework import status


from wijha_api.serializers.user_serializer import UserSerializer
from wijha_api.utils.password_hashing import *
from wijha_api.models.user import *


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

    @action(detail=False, methods=["post"])
    def validate_password(self, request):
        """
        Serves as an endpoint to validate passwords upon user login
        @TODO Decrypt client-side encrypted password first
        """
        try:
            user_data = User.objects(username=request.data["username"]).get()
            if check_password(request.data["password"], user_data["password"]):
                return Response(status=status.HTTP_200_OK)
            else:
                return Response(status=status.HTTP_406_NOT_ACCEPTABLE)
        except DoesNotExist as e:
            return Response(status=status.HTTP_404_NOT_FOUND, data={"Reason": "User not found"})
