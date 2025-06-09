from rest_framework.renderers import JSONRenderer
from rest_framework.test import APITestCase
from rest_framework import status
from django.test import tag
from wijha_api.models.tour import Tour

from wijha_api.serializers.ordered_location_serializer import OrderedLocationSerializer
from wijha_api.models.ordered_location import OrderedLocation


class OrderedLocationTests(APITestCase):
    """
    Tests the list, retrieve and create endpoints
    of the OrderedLocationViewSet
    """

    def test_list_ordered_location(self):
        """
        Ensure all OrderedLocations are returned
        """
        url = "/ordered-location/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_detail_ordered_location(self):
        """
        Ensure a specific OrderedLocation is returned
        """
        url = "/ordered-location/ordered-location-test/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["name"], "ordered-location-test")

    @tag("skip")
    def test_create_ordered_location(self):
        """
        Ensure a new OrderedLocation can be created
        """
        url = "/ordered-location/"

        tour = Tour.objects(title="tour_test").get()
        ordered_location_data = OrderedLocation(
            name="ordered-location-test-new",
            description="description",
            location_fact="fact",
            location_number=1,
            image_url="image",
            tour=tour,
        )

        ordered_location_data = OrderedLocationSerializer(ordered_location_data).data
        json = JSONRenderer().render(ordered_location_data)

        response = self.client.post(url, data=json, content_type="application/json")
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def tearDown(self):
        """
        Delete documents created for test
        """
        OrderedLocation.objects(name="ordered-location-test-new").delete()
