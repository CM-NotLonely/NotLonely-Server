# -*- coding:utf-8 -*-
from django.shortcuts import render
from models import *
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse
from user_auth import user_auth
import json
import hashlib
import sys

reload(sys)
sys.setdefaultencoding('utf-8')
# Create your views here.


@csrf_exempt
def register(request):
    print '111'
    responsedata={}
    stu_number_POST = request.POST['stu_number'].encode('utf-8')
    stu_password_POST = request.POST['stu_password'].encode('utf-8')
    username_POST = request.POST['username'].encode('utf-8')
    password_POST = request.POST['password'].encode('utf-8')
    repassword_POST = request.POST['repassword'].encode('utf-8')
    nickname_POST = (request.POST['nickname']).encode('utf-8')
    qq_POST = request.POST['qq'].encode('utf-8')
    if User.objects.filter(stu_number = stu_number_POST):
        responsedata['status'] = '300'
        responsedata['msg'] = '该学号已被注册'.encode('utf-8')
    elif User.objects.filter(username = username_POST):
        responsedata['status'] = '301'
        responsedata['msg'] = str('该用户名已被注册').encode('utf-8')
    elif password_POST != repassword_POST:
        responsedata['status'] = '302'
        responsedata['msg'] = str('两次输入密码不一致').encode('utf-8')
    elif user_auth(stu_number_POST, stu_password_POST) == -1:
        responsedata['status'] = '303'
        responsedata['msg'] = '信息门户学号或密码错误'
    else:
        password_POST = hashlib.md5(password_POST).hexdigest()
        user = User(stu_number = stu_number_POST, stu_password = stu_password_POST,
                    username = username_POST, password = password_POST,nickname = nickname_POST,
                    qq = qq_POST)
        user.save()
        responsedata['status'] = '0'
        responsedata['msg'] = '注册成功'

    return HttpResponse(json.dumps(responsedata), content_type="application/json; charset='utf-8'")

@csrf_exempt
def login(request):
    responseData = {}
    if request.method == 'POST':
        username_POST = request.POST['username'].encode('utf-8')
        password_POST = request.POST['password'].encode('utf-8')
        userList = User.objects.filter(username = username_POST)
        print userList[0].password
        print hashlib.md5(password_POST).hexdigest()
        if userList:
            user = userList[0]
            if hashlib.md5(password_POST).hexdigest() == user.password:
                request.session['username'] = username_POST
                responseData['status'] = '0'
                responseData['msg']  = 'login success'
                responseData['nickname'] = user.nickname
            else:
                responseData['status'] = '300'
                responseData['msg'] = 'wrong password'
        else:
            responseData['status'] = '301'
            responseData['msg'] = 'user does not exist'
        return HttpResponse(json.dumps(responseData), content_type="application/json; charset='utf-8'")




@csrf_exempt
def test(request):
    str1 = '中文输入'
    print str1.decode('utf-8')
    responseData = {}
    print type(str1)
    responseData['msg'] = 'test'
    # password = str(request.POST['password']).encode('utf-8')
    password = request.POST['password']
    print type(password)
    print request.session['username']
    # md5=hashlib.md5(‘字符串’.encode(‘utf-8′)).hexdigest()
    print password

    return HttpResponse(json.dumps(responseData), content_type="application/json")
