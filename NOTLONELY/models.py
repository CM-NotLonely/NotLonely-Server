# -*- coding:utf-8 -*-
from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.
# 标签

# class Tag(models.Model):
#     name = models.CharField(max_length=30, verbose_name='标签名称')
#
#     class Meta:
#         verbose_name = '标签'
#         verbose_name_plural = verbose_name
#
#     def __unicode__(self):
#         return self.name


# user

class User(models.Model):
    avatar = models.ImageField(upload_to='avatar/%Y/%m', default='avatar/default.jpg', max_length=200, blank=True, null=True, verbose_name=' 用户头像')
    stu_number = models.CharField(max_length=13, unique=True, verbose_name='学号')
    stu_password = models.CharField(max_length=20, verbose_name='教务系统密码')
    username = models.CharField(max_length=10, unique=True, verbose_name='用户名')
    password = models.CharField(max_length=128, verbose_name='密码')
    nickname = models.CharField(max_length=128, verbose_name='昵称')
    sex = models.CharField(max_length=10, default='female', verbose_name='性别')
    qq = models.CharField(max_length=20, verbose_name='QQ号码')
    desc = models.CharField(max_length=200, blank=True, null=True, verbose_name='个人简介')
    rose = models.IntegerField(default=0, verbose_name='点赞数')
    tag = models.ManyToManyField('Tag', verbose_name='个人标签', related_name='beCommitted', blank=True)

    class Meta:
        verbose_name = '用户'
        verbose_name_plural = verbose_name
        ordering = ['-id']

    def __unicode__(self):
        return self.username

class Tag(models.Model):
    tag = models.CharField(max_length=10, blank=True, null=True, verbose_name='个人标签')
    news = models.ForeignKey('News', verbose_name='活动', related_name='news_tag')
    commitor = models.ForeignKey('User', verbose_name='评价用户', related_name='commitor')
    giveRose = models.BooleanField(default = False, verbose_name='是否送花')
    postTime = models.DateTimeField(auto_now_add = True, verbose_name = '请求时间')
    
    class Meta:
        verbose_name = '标签'
        verbose_name_plural = verbose_name
        ordering = ['-postTime']

    def __unicode__(self):
        return self.commitor.username + '的评价'

class Newspic(models.Model):
    newsPic = models.ImageField(upload_to='newspic/%Y/%m', blank=True, null=True, verbose_name='消息照片')

    class Meta:
        verbose_name = '消息照片'
        verbose_name_plural = verbose_name

    def __unicode__(self):
        return self.newsPic.name

class Relation(models.Model):
    user = models.ForeignKey(User, verbose_name='活动参与者')
    result = models.BooleanField(default=False, verbose_name='是否同意')
    postTime = models.DateTimeField(auto_now_add = True, verbose_name = '请求时间')

    class Meta:
        verbose_name = '消息关系结果'
        verbose_name_plural = verbose_name
        ordering = ['-postTime']

    def __unicode__(self):
        return self.user.username + '的请求,' + str(self.result)

class News(models.Model):
    title = models.CharField(max_length=20, verbose_name='约标题')
    desc = models.TextField(blank=True, null=True, verbose_name='约简介')
    meetTime = models.DateTimeField(blank=True, null=True, verbose_name='相约时间')
    meetPlace = models.CharField(max_length=50, blank=True, null=True, verbose_name='相约地点')
    postTime = models.DateTimeField(auto_now_add = True, verbose_name='发布时间')
    personNumberAll = models.IntegerField(verbose_name='参与总人数')
    personNumberIn = models.IntegerField(verbose_name='已参与人数')
    remark = models.CharField(blank=True, null=True, max_length=100, verbose_name='备注')
    initiator = models.ForeignKey(User, verbose_name='发起人')
    tag = models.CharField(max_length=100, verbose_name='活动标签')
    is_finish = models.BooleanField(default=False, verbose_name='活动是否结束')
    newsPic = models.ManyToManyField(Newspic, verbose_name='活动照片', blank=True)
    relation = models.ManyToManyField(Relation, verbose_name='活动参与关系', blank=True, related_name='news')

    class Meta:
        verbose_name = '消息'
        verbose_name_plural = verbose_name
        ordering = ['-postTime']

    def __unicode__(self):
        return self.title
