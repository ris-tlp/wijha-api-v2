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
    blog_post_viewset,
    category_viewset,
    custom_location_viewset,
    ordered_location_viewset,
    tag_viewset,
    tour_include_viewset,
    tour_viewset,
    user_viewset,
    subforum_viewset,
    forum_post_viewset,
    location_viewset,
    upload_image_view,
)

router = DefaultRouter()
router.register(r"tag", tag_viewset.TagViewSet, r"tag")
router.register(r"category", category_viewset.CategoryViewSet, r"category")
router.register(r"tour-include", tour_include_viewset.TourIncludeViewSet, r"tour-include")
router.register(r"user", user_viewset.UserViewSet, r"user")
router.register(r"subforum", subforum_viewset.SubforumViewSet, r"subforum")
router.register(r"forum-post", forum_post_viewset.ForumPostViewSet, r"forum-post")
router.register(r"location", location_viewset.LocationViewSet, r"location")
router.register(r"blog-post", blog_post_viewset.BlogPostViewSet, r"blog-post")
router.register(r"tour", tour_viewset.TourViewSet, r"tour")
router.register(
    r"ordered-location", ordered_location_viewset.OrderedLocationViewSet, r"ordered-location"
)
router.register(
    r"custom-location", custom_location_viewset.CustomLocationViewSet, r"custom-location"
)

# pprint.pprint(router.get_urls())

urlpatterns = [
    path("", include((router.urls))),
    path(r"upload-image/", upload_image_view.upload_image, name="upload-image"),
]
