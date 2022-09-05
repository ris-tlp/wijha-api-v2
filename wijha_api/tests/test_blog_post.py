from rest_framework.renderers import JSONRenderer
from rest_framework.test import APITestCase
from rest_framework import status
from django.test import tag

from wijha_api.serializers.blog_post_serializer import BlogPostSerializer
from wijha_api.models.blog_post import BlogPost
from wijha_api.models.user import User
from wijha_api.models.tag import Tag


class BlogPostTests(APITestCase):
    """
    Tests the list, retrieve and create endpoints
    of the BlogPostViewSet
    """

    def test_list_blog_post(self):
        """
        Ensure all BlogPosts are returned
        """
        url = "/blog-post/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_detail_forum_post(self):
        """
        Ensure a specific BlogPost is returned
        """
        url = "/blog-post/blog-post_test/"
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["title"], "blog-post_test")

    @tag("skip")
    def test_create_forum_post(self):
        """
        Ensure a new BlogPost can be created
        """
        url = "/forum-post/"

        user = User.objects(username="omar").get()
        tag1 = Tag.objects(title="tag-test").get()
        blog_post_data = BlogPost(
            title="blog-post_test_new",
            content="content",
            author=User,
            published_status=True,
            image_url="image.jpg",
            likes=0,
            tags=[tag1],
        )

        blog_post_data = BlogPostSerializer(blog_post_data).data
        json = JSONRenderer().render(blog_post_data)

        response = self.client.post(url, data=json, content_type="application/json")
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def tearDown(self):
        """
        Delete documents created for test
        """
        BlogPost.objects(title="blog-post_test_new").delete()
