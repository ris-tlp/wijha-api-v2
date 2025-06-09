from rest_framework.renderers import JSONRenderer
from rest_framework.test import APITestCase
from rest_framework import status
from django.test import tag

from wijha_api.serializers.custom_location_serializer import CustomLocationSerializer
from wijha_api.models.custom_location import CustomLocation


class CustomLocationTests(APITestCase):
    """
    Tests the list, retrieve and create endpoints
    of the CustomLocationViewSet
    """

    def test_list_custom_location(self):
        """
        Ensure all CustomLocation are returned
        """
        url = "/custom-location/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_detail_custom_location(self):
        """
        Ensure a specific CustomLocation is returned
        """
        url = "/custom-location/custom-location_test/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["name"], "custom-location_test")

    @tag("skip")
    def test_create_forum_post(self):
        """
        Ensure a new CustomLocation can be created
        """
        url = "/custom-location/"

        custom_location_data = CustomLocation(
            name="custom-location_test_new",
            description="custom-location_description_new",
            location_fact="custom-location_fact",
            location_number=1,
            image_url="image.jpg",
            coordinates_latitude=1.12345,
            coordinates_longitude=2.12345,
            guide=None,
        )

        post_data = CustomLocationSerializer(post_data).data
        json = JSONRenderer().render(post_data)

        response = self.client.post(url, data=json, content_type="application/json")
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def tearDown(self):
        """
        Delete documents created for test
        """
        CustomLocation.objects(name="custom-location_test_new").delete()
