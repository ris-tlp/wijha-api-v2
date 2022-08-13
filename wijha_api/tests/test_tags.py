import json
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase


class TagTests(APITestCase):
    def test_list_tag(self):
        """
        Ensure all tags are returned
        """
        url = "/tag/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_detail_tag(self):
        """
        Ensure a specific tag is returned
        """
        url = "/tag/tag-test/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["title"], "tag-test")

    def test_create_tag(self):
        """
        Ensure a new tag can be created
        """
        url = "/tag/"
        data = {"title": "tag-test-new", "icon": "tag-icon-test-new"}
        response = self.client.post(url, data=data, format="json")
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
