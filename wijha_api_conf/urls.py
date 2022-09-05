"""wijha_api_conf URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
import io
import pprint
from django.urls import include, path
from rest_framework_mongoengine.routers import DefaultRouter
from wijha_api.views import (
    category_viewset,
    tag_viewset,
    tour_include_viewset,
    user_viewset,
    subforum_viewset,
    forum_post_viewset,
)

router = DefaultRouter()
router.register(r"tag", tag_viewset.TagViewSet, r"tag")
router.register(r"category", category_viewset.CategoryViewSet, r"category")
router.register(r"tour-include", tour_include_viewset.TourIncludeViewSet, r"tour-include")
router.register(r"user", user_viewset.UserViewSet, r"user")
router.register(r"subforum", subforum_viewset.SubforumViewSet, r"subforum")
router.register(r"forum-post", forum_post_viewset.ForumPostViewSet, r"forum-post")


# pprint.pprint(router.get_urls())

urlpatterns = [
    path("", include((router.urls))),
]

#############
###TESTING###
#############


# from wijha_api.serializers.forum_post_serializer import ForumPostSerializer
# from wijha_api.models.forum_post import ForumPost
# from wijha_api.models.subforum import Subforum
# from wijha_api.models.user import User
# from wijha_api.models.tag import Tag

# # user = User.objects(username="omar").get()
# # tag1 = Tag.objects(title="tag-test").get()
# # tag2 = Tag.objects(title="title1-test-bruh").get()
# # subforum = Subforum.objects(title="subforum-test").get()
# # post = ForumPost(
# #     title="title", content="content", likes=4, author=user, tags=[tag1, tag2], subforum=subforum
# # ).save()
# # comment = ForumPost(
# #     title="comment title",
# #     content="comment content",
# #     likes=0,
# #     author=user,
# #     tags=[tag1],
# #     subforum=subforum,
# #     parent_post=post,
# # ).save()

# # post = ForumPost.objects(title="comment title").get()
# # serializer = ForumPostSerializer(post).data
# # print(serializer)
# # # print(post.author)


# from wijha_api.serializers.user_serializer import UserSerializer
# from wijha_api.serializers.tag_serializer import TagSerializer
# from wijha_api.serializers.subforum_serializer import SubforumSerializer
# from rest_framework.renderers import JSONRenderer
# from rest_framework.parsers import JSONParser


# # user = User.objects(username="omar").get()
# # tag1 = Tag.objects(title="tag-test").get()
# # subforum = Subforum.objects(title="subforum-test").get()
# # post_data = ForumPost(
# #     title="forum-post-title-test-new",
# #     content="forum-post-title-test-content",
# #     likes=0,
# #     author=user,
# #     tags=[tag1],
# #     subforum=subforum,
# #     parent_post=None,
# # ).save()


# post_data = ForumPost.objects(title="forum-post-title-test-new").get()
# serialized_data = ForumPostSerializer(post_data).data

# json = JSONRenderer().render(serialized_data)
# stream = io.BytesIO(json)
# data = JSONParser().parse(stream)

# # print(data)
# # print(type(data))

# serializer = ForumPostSerializer(data=data)
# print(f"Serializer valid: {serializer.is_valid()}")
# print(serializer.validated_data)

# # s = ForumPostSerializer()
# # print(repr(s))
