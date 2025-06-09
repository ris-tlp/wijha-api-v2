from django.test import tag
from datetime import datetime
from rest_framework import status
from rest_framework.test import APITestCase
from rest_framework.renderers import JSONRenderer

from wijha_api.models.tour import Tour
from wijha_api.models.user import User
from wijha_api.models.category import Category
from wijha_api.models.location import Location
from wijha_api.models.tour_include import TourInclude
from wijha_api.serializers.tour_serializer import TourSerializer


class TourTests(APITestCase):
    """
    Tests the list, retrieve and create endpoints
    of the TourViewSet
    """

    def test_list_tour(self):
        """
        Ensure all Tours are returned
        """
        url = "/tour/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_detail_forum_post(self):
        """
        Ensure a specific Tour is returned
        """
        url = "/tour/tour_test/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["title"], "tour_test")

    @tag("skip")
    def test_create_forum_post(self):
        """
        Ensure a new Tour can be created
        """
        url = "/tour/"

        user = User.objects(username="omar").get()
        province = Location.objects(name="location-test").get()
        category1 = Category.objects(title="category1").get()
        include1 = TourInclude.objects(title="tourinclude-test").get()

        tour_data = Tour(
            title="tour_test_new",
            description="tour_description",
            capacity=5,
            rating=4.5,
            price=1500,
            date=datetime.now(),
            active=False,
            history=False,
            guide=user,
            province=province,
            images=["image1", "image2"],
            categories=[category1],
            locations=[],
            included=[include1],
        )

        tour_data = TourSerializer(tour_data).data
        json = JSONRenderer().render(tour_data)

        response = self.client.post(url, data=json, content_type="application/json")
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def tearDown(self):
        """
        Delete documents created for test
        """
        Tour.objects(title="tour_test_new").delete()
