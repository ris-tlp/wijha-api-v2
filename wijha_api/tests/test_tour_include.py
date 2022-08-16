from rest_framework import status
from rest_framework.test import APITestCase


class TourIncludeTests(APITestCase):
    """
    Tests the list, retrieve and create endpoints
    of the TourIncludeViewSet
    """

    def test_list_category(self):
        """
        Ensure all TourInclude objects are returned
        """
        url = "/tour-include/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_detail_category(self):
        """
        Ensure a specific TourInclude object is returned
        """
        url = "/tour-include/tourinclude-test/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["title"], "tourinclude-test")

    def test_create_category(self):
        """
        Ensure a new TourInclude object can be created
        """
        url = "/category/"
        data = {"title": "tourinclude-test-new", "icon": "tourinclude-icon-test-new"}
        response = self.client.post(url, data=data, format="json")
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
