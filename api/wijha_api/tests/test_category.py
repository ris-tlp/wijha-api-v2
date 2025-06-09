from rest_framework import status
from rest_framework.test import APITestCase
from wijha_api.models.category import Category


class CategoryTests(APITestCase):
    """
    Tests the list, retrieve and create endpoints
    of the CategoryViewSet
    """

    def test_list_category(self):
        """
        Ensure all categories are returned
        """
        url = "/category/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_detail_category(self):
        """
        Ensure a specific category is returned
        """
        url = "/category/category-test/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["title"], "category-test")

    def test_create_category(self):
        """
        Ensure a new category can be created
        """
        url = "/category/"
        data = {"title": "category-test-new", "icon": "category-icon-test-new"}
        response = self.client.post(url, data=data, format="json")
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def tearDown(self) -> None:
        """
        Delete documents created for test
        """
        Category.objects(title="category-test-new").delete()
