from NOTLONELY.models import *
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from datetime import *
import json
import math
from django.core.serializers.json import DjangoJSONEncoder

def getActivity(request):
	MAXITEMS = 20.0
	responsedata = {}
	result = []
	tag = request.GET.get('tag')
	page = request.GET.get('page')
	username = request.session.get('username')
	if not request.session.get('username'):
		responsedata['status'] = -2
		responsedata['error'] = 'no cookies'
		return HttpResponse(json.dumps(responsedata),content_type="application/json")
	if not page:
		page = 1
	elif int(page) < 1:
		page = 1
	else:
		page = int(page)
	end = MAXITEMS*page
	start = MAXITEMS*(page-1)
	if tag:
		count = News.objects.filter(tag = tag,is_finish = False).count()
		if start >= count and count!=0:
			responsedata['status'] = -1
			responsedata['error'] = 'out of range'
		else:
			paticipator = User.objects.get(username = username)
			if end > count:
				end = count
			ns = News.objects.filter(tag = tag,is_finish = False)[start:end]
			for n in ns:
				tmp = {}
				tmp['activityId'] = n.id
				tmp['title'] = n.title
				tmp['desc'] = n.desc
				tmp['meetTime'] = n.meetTime.strftime("%Y-%m-%d %H:%M") 
				tmp['meetPlace'] = n.meetPlace
				tmp['postTime'] = n.postTime.strftime("%Y-%m-%d %H:%M") 
				tmp['personNumberAll'] = n.personNumberAll
				tmp['personNumberIn'] = n.personNumberIn
				tmp['remark'] = n.remark
				tmp['initiator'] = n.initiator.nickname
				tmp['initiatorId'] = n.initiator.id
				tmp['avatar'] = n.initiator.avatar.url
				tmp['tag'] = n.tag
				tmp['images'] = []
				images = n.newsPic.all()
				for image in images:
					tmp['images'].append(image.newsPic.url)
				relations = n.relation.filter(user = paticipator)
				if relations:
					tmp['haspost'] = True
				else:
					tmp['haspost'] = False
				result.append(tmp)
			responsedata['status'] = 0
			responsedata['num'] = len(ns)
			responsedata['page'] = int(math.ceil(len(ns)/MAXITEMS))
			responsedata['items'] = result
	else:
		count = News.objects.filter(is_finish = False).count()
		if start >= count and count!=0:
			responsedata['status'] = -1
			responsedata['error'] = 'out of range'
		else:
			paticipator = User.objects.get(username = username)
			if end > count:
				end = count
			ns = News.objects.filter(is_finish = False)[start:end]
			for n in ns:
				tmp = {}
				tmp['activityId'] = n.id
				tmp['title'] = n.title
				tmp['desc'] = n.desc
				tmp['meetTime'] = n.meetTime.strftime("%Y-%m-%d %H:%M") 
				tmp['meetPlace'] = n.meetPlace
				tmp['postTime'] = n.postTime.strftime("%Y-%m-%d %H:%M") 
				tmp['personNumberAll'] = n.personNumberAll
				tmp['personNumberIn'] = n.personNumberIn
				tmp['remark'] = n.remark
				tmp['initiator'] = n.initiator.nickname
				tmp['initiatorId'] = n.initiator.id
				tmp['avatar'] = n.initiator.avatar.url
				tmp['tag'] = n.tag
				tmp['images'] = []
				images = n.newsPic.all()
				for image in images:
					tmp['images'].append(image.newsPic.url)
				relations = n.relation.filter(user = paticipator)
				if relations or n.initiator==paticipator:
					tmp['haspost'] = True
				else:
					tmp['haspost'] = False
				result.append(tmp)
			responsedata['status'] = 0
			responsedata['num'] = len(ns)
			responsedata['page'] = int(math.ceil(len(ns)/MAXITEMS))
			responsedata['items'] = result
	return HttpResponse(json.dumps(responsedata,ensure_ascii=False,cls=DjangoJSONEncoder), content_type='application/json;charset=utf-8')

@csrf_exempt
def postActivity(request):
	responsedata = {}
	username = request.session.get('username')
	if username:
		title = request.POST.get('title')
		desc = request.POST.get('desc')
		mtime = request.POST.get('meetTime')
		if mtime:
			mtime = float(mtime)
			meetTime = datetime.fromtimestamp(mtime)
		meetPlace = request.POST.get('meetPlace')
		personNumberAll = request.POST.get('personNumberAll')
		personNumberIn = 1
		remark = request.POST.get('remark')
		initiator = User.objects.get(username = username)
		tag = request.POST.get('tag')
		if not title or not mtime or not meetPlace or not personNumberAll or not tag:
			responsedata['status'] = -2
			responsedata['error'] = 'null'
			return HttpResponse(json.dumps(responsedata),content_type="application/json")
		news = News(title = title, desc = desc, meetTime = meetTime, meetPlace = meetPlace, personNumberAll = personNumberAll, personNumberIn = personNumberIn, remark =remark, initiator = initiator, tag = tag,is_finish = False)
		news.save()
		imageCount = len(request.FILES)
		for i in range(imageCount):
			Nspic = Newspic(newsPic = request.FILES['image'+str(i)])
			Nspic.save()
			news.newsPic.add(Nspic)
		responsedata['status'] = 0
	else:
		responsedata['status'] = -1
		responsedata['error'] = 'no cookies'
	return HttpResponse(json.dumps(responsedata),content_type="application/json")

def removeActivity(request):
	responsedata = {}
	username = request.session.get('username')
	if username:
		user = User.objects.get(username = username)
		nsid = request.GET.get('activityId')
		ns = News.objects.filter(initiator = user, id = nsid)
		if ns:
			ns.delete()
			responsedata['status'] = 0
		else:
			responsedata['status'] = -2
			responsedata['error'] = 'not have this activity'
	else:
		responsedata['status'] = -1
		responsedata['error'] = 'no cookies'
	return HttpResponse(json.dumps(responsedata),content_type="application/json")