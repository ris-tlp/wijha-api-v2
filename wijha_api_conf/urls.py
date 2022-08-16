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
from wijha_api.views import category_viewset, tag_viewset, tour_include_viewset

router = DefaultRouter()
router.register(r"tag", tag_viewset.TagViewSet, r"tag")
router.register(r"category", category_viewset.CategoryViewSet, r"category")
router.register(r"tour-include", tour_include_viewset.TourIncludeViewSet, r"tour-include")


# pprint.pprint(router.get_urls())

urlpatterns = [
    path("", include((router.urls))),
]
