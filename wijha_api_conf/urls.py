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

from wijha_api.serializers.forum_post_serializer import ForumPostSerializer

# user = User.objects(username="omar").get()
# tag1 = Tag.objects(title="tag-test").get()
# tag2 = Tag.objects(title="title1-test-bruh").get()
# post = ForumPost(title="title", content="content", likes=4, author=user, tags=[tag1, tag2]).save()
# post = ForumPost.objects(title="title").get()
# serializer = ForumPostSerializer(post).data
# print(serializer)
# print(post.author)
