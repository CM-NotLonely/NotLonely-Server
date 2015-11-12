# -*- coding:utf-8 -*-
"""NOT_LONELY URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.8/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Add an impo0rt:  from blog import urls as blog_urls
    2. Add a URL to urlpatterns:  url(r'^blog/', include(blog_urls))
"""
from django.conf.urls import include, url
from django.contrib import admin

from NOTLONELY.user_view import *
from NOTLONELY.square import *
from NOTLONELY.relation import *
from django.conf import settings

urlpatterns = [
    url(r"^uploads/(?P<path>.*)$", \
                "django.views.static.serve", \
                {"document_root": settings.MEDIA_ROOT,}),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^register/', register),
    url(r'^login/', login),
    url(r'^upload_avatar/', upload_avatar),
    url(r'^getActivity/$', getActivity),
    url(r'^postActivity/$',postActivity),
    url(r'^removeActivity/$',removeActivity),
    url(r'^takein/$',takein),
    url(r'^userSetting/', userSetting),
    url(r'^confirmRelation/$',confirmRelation),
    url(r'^getMyPostAllRelation/$',getMyPostAllRelation),
    url(r'^getMyPost/$',getMyPost),
    url(r'^getMyRequest/$',getMyRequest),
    url(r'^closeNews/$',closeNews),
    url(r'^getMyRequestAllRelation/$',getMyRequestAllRelation),
    url(r'^commit/$', commit),
    url(r'^userInfo/$', userInfo),
    url(r'^getMyGroupTel/$', getMyGroupTel),
    url(r'^getInitiatorTel/$',getInitiatorTel),
]
