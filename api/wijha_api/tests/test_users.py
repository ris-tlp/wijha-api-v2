from django.test import tag
from rest_framework import status
from rest_framework.test import APITestCase
from wijha_api.models.user import User
from wijha_api.serializers.user_serializer import UserSerializer


class TagTests(APITestCase):
    def test_detail_user(self):
        """
        Ensure a specific user is returned
        """
        url = "/user/omar/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["username"], "omar")

    def test_create_user(self):
        """
        Ensure a new user can be created
        """
        url = "/user/"
        user_data = User(
            username="username",
            password="password",
            profile_picture="",
            travel_points=0,
            user_type="",
        )
        data = UserSerializer(user_data).data
        response = self.client.post(url, data=data, format="json")
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_validate_correct_password(self):
        """
        Validate a user's password on login
        @TODO decrypt client-side encrypted password
        """
        url = "/user/validate_password/"

        data = {"username": "omar", "password": "password"}
        response = self.client.post(url, data=data, format="json")
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    @tag("skip")
    def test_validate_incorrect_password(self):
        """
        Ensure an incorrect password is not validated.
        @TODO decrypt client-side encrypted password
        """
        url = "/user/validate_password/"

        data = {"username": "omar", "password": "wrong-password"}
        response = self.client.post(url, data=data, format="json")
        self.assertEqual(response.status_code, status.HTTP_406_NOT_ACCEPTABLE)

    def tearDown(self):
        """
        Delete documents created for test
        """
        User.objects(username="username").delete()
