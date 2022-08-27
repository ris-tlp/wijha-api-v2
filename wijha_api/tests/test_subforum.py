from rest_framework import status
from rest_framework.test import APITestCase
from wijha_api.models.subforum import Subforum
from wijha_api.serializers.subforum_serializer import SubforumSerializer


class SubforumTests(APITestCase):
    def test_list_subforum(self):
        """
        Ensure all subforums are returned
        """
        url = "/subforum/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_detail_subforum(self):
        """
        Ensure a specific subforum is returned
        """
        url = "/subforum/subforum-test/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["title"], "subforum-test")

    def test_create_subforum(self):
        """
        Ensure a new subforum can be created
        """
        url = "/subforum/"
        subforum_data = Subforum(
            title="subforum-test-new",
            description="subforum-test-description",
            icon="image.png",
            total_posts=5,
        )
        data = SubforumSerializer(subforum_data).data
        response = self.client.post(url, data=data, format="json")
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def tearDown(self) -> None:
        """
        Delete documents created for test
        """
        Subforum.objects(title="subforum-test-new").delete()
