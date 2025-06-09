from rest_framework.renderers import JSONRenderer
from rest_framework.test import APITestCase
from rest_framework import status
from django.test import tag

from wijha_api.serializers.forum_post_serializer import ForumPostSerializer
from wijha_api.models.forum_post import ForumPost
from wijha_api.models.subforum import Subforum
from wijha_api.models.tag import Tag
from wijha_api.models.user import User


class ForumPostTests(APITestCase):
    """
    Tests the list, retrieve and create endpoints
    of the ForumPostViewSet
    """

    def test_list_forum_post(self):
        """
        Ensure all ForumPosts are returned
        """
        url = "/forum-post/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_detail_forum_post(self):
        """
        Ensure a specific ForumPost is returned
        """
        url = "/forum-post/forum-post-title-test/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["title"], "forum-post-title-test")

    @tag("skip")
    def test_create_forum_post(self):
        """
        Ensure a new ForumPost can be created
        """
        url = "/forum-post/"

        user = User.objects(username="omar").get()
        tag1 = Tag.objects(title="tag-test").get()
        subforum = Subforum.objects(title="subforum-test").get()
        post_data = ForumPost(
            title="forum-post-title-test-new",
            content="forum-post-title-test-content",
            likes=0,
            author=user,
            tags=[tag1],
            subforum=subforum,
            parent_post=None,
        )

        post_data = ForumPostSerializer(post_data).data
        json = JSONRenderer().render(post_data)

        response = self.client.post(url, data=json, content_type="application/json")
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def tearDown(self):
        """
        Delete documents created for test
        """
        ForumPost.objects(title="forum-post-title-test-new").delete()
