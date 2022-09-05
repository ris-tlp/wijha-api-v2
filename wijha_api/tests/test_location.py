from rest_framework.renderers import JSONRenderer
from rest_framework.test import APITestCase
from rest_framework import status
from django.test import tag

from wijha_api.serializers.location_serializer import LocationSerializer
from wijha_api.models.location import Location


class LocationTests(APITestCase):
    """
    Tests the list, retrieve and create endpoints
    of the LocationViewSet
    """

    def test_list_location(self):
        """
        Ensure all Locations are returned
        """
        url = "/location/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_detail_forum_post(self):
        """
        Ensure a specific Location is returned
        """
        url = "/location/location-test/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["name"], "location-test")

    @tag("skip")
    def test_create_forum_post(self):
        """
        Ensure a new Location can be created
        """
        url = "/location/"

        location_data = Location(
            name="location-test-new",
            description="location-description-test-new",
            image_url="newtest.jpg",
            province=None,
        )

        post_data = LocationSerializer(location_data).data
        json = JSONRenderer().render(post_data)

        response = self.client.post(url, data=json, content_type="application/json")
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def tearDown(self):
        """
        Delete documents created for test
        """
        Location.objects(name="location-test-new").delete()
