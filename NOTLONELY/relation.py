from NOTLONELY.models import *
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from datetime import *
import json
from django.core.serializers.json import DjangoJSONEncoder

def takein(request):
	responsedata = {}
	username = request.session.get('username')
	if username:
		activityId = request.GET.get('activityId')
		activity = News.objects.filter(id = activityId)
		if not activity:
			responsedata['status'] = -3
			responsedata['error'] = 'error activity info'
		else:
			responsedata['status'] = 0
			user = User.objects.get(username = username)
			if activity[0].relation.filter(user = user):
				responsedata['status'] = -2
				responsedata['error'] = 'exists'
			else:
				beforeRelation = Relation()
				relation = Relation(user = user, result = False)
				relation.save()
				activity[0].relation.add(relation)
				responsedata['status'] = 0
	else:
		responsedata['status'] = -1
		responsedata['error'] = 'no cookies'
	return HttpResponse(json.dumps(responsedata),content_type="application/json")


def confirmRelation(request):
	responsedata = {}
	username = request.session.get("username")
	if username:
		activityId = request.GET.get("activityId")
		initiator = User.objects.get(username = username)
		news = News.objects.filter(id = activityId, initiator = initiator)
		if news:
			personInId = request.GET.get("personInId")
			personIn = User.objects.get(id = personInId)
			relation = news[0].relation.filter(user = personIn)
			if not relation:
				responsedata['status'] = -2
				responsedata['error'] = 'this perison not in this activity'
			elif (relation[0].result == False):
				personNumberAll= news[0].personNumberAll
				personNumberIn = news[0].personNumberIn
				if (personNumberIn < personNumberAll):
					personNumberIn = personNumberIn + 1
					relation.update(result = True)
					news.update(personNumberIn = personNumberIn)
					responsedata['status'] = 0
				else:
					responsedata['status'] = -4
					responsedata['error'] = 'out of range'
			else:
				responsedata['status'] = 0
		else:
			responsedata['status'] = -3
			responsedata['error'] = 'error activity info'
	else:
		responsedata['status'] = -1
		responsedata['error'] = 'no cookies'
	return HttpResponse(json.dumps(responsedata),content_type="application/json")

def getMyPostAllRelation(request):
	responsedata = {}
	relationList = []
	username = request.session.get("username")
	if username:
		activityId = request.GET.get("activityId")
		initiator = User.objects.get(username = username)
		news = News.objects.filter(id = activityId, initiator = initiator)
		if news:
			relations = news[0].relation.all()
			if relations:
				for relation in relations:
					tmp = {}
					tmp['personInId'] = relation.user.id
					tmp['personInAvatar'] = relation.user.avatar.url
					tmp['personInNickname'] = relation.user.nickname
					tmp['relationDeal'] = relation.result
					tmp['postTime'] = relation.postTime.strftime("%Y-%m-%d %H:%M") 
					tmp['desc'] = relation.user.desc
					tmp['sex'] = relation.user.sex
					tmp['tag'] = []
					tagss = relation.user.tag.all()
					for tag in tagss:
						tmp['tag'].append(tag.tag)

					tag = Tag.objects.filter(news = news, commitor = initiator)
					if tag:
						if relation.user in tag[0].beCommitted.all():
							tmp['commit'] = True
							tmp['giveRose'] = tag[0].giveRose
						else:
							tmp['commit'] = False
							tmp['giveRose'] = False
					else:
						tmp['commit'] = False
						tmp['giveRose'] = False
					relationList.append(tmp)
				responsedata['num'] = len(relations)
			else:
				responsedata['num'] = 0
			responsedata['relationList'] = relationList
			responsedata['status'] = 0
		else:
			responsedata['status'] = -2
			responsedata['error'] = 'error activity info'
	else:
		responsedata['status'] = -1
		responsedata['error'] = 'no cookies'
	return HttpResponse(json.dumps(responsedata,ensure_ascii=False,cls=DjangoJSONEncoder), content_type='application/json;charset=utf-8')

def getMyPost(request):
	responsedata = {}
	myPostList = []
	username = request.session.get("username")
	if username:
		initiator = User.objects.get(username = username)
		ns = News.objects.filter(initiator = initiator)
		if ns:
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
				tmp['is_finish'] = n.is_finish
				tmp['images'] = []
				images = n.newsPic.all()
				for image in images:
					tmp['images'].append(image.newsPic.url)
				myPostList.append(tmp)
			responsedata['num']	= len(ns)
		else:
			responsedata['num'] = 0
		responsedata['status'] = 0
		responsedata['myPostList'] = myPostList
	else:
		responsedata['status'] = -1
		responsedata['error'] = 'no cookies'
	return HttpResponse(json.dumps(responsedata,ensure_ascii=False,cls=DjangoJSONEncoder), content_type='application/json;charset=utf-8')

def getMyRequest(request):
	responsedata = {}
	myRequestList = []
	username = request.session.get("username")
	if username:
		paticipator = User.objects.get(username = username)
		relations = Relation.objects.filter(user = paticipator)
		if relations:
			for relation in relations:
				n = relation.news.get()
				tmp = {}
				tmp['relationDeal'] = relation.result
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
				tmp['is_finish'] = n.is_finish
				tmp['images'] = []
				images = n.newsPic.all()
				for image in images:
					tmp['images'].append(image.newsPic.url)
				myRequestList.append(tmp)
			responsedata['num']	= len(relations)
		else:
			responsedata['num'] = 0
		responsedata['status'] = 0
		responsedata['myRequestList'] = myRequestList
	else:
		responsedata['status'] = -1
		responsedata['error'] = 'no cookies'
	return HttpResponse(json.dumps(responsedata,ensure_ascii=False,cls=DjangoJSONEncoder), content_type='application/json;charset=utf-8')

def closeNews(request):
	responsedata = {}
	username = request.session.get('username')
	if username:
		user = User.objects.get(username = username)
		nsid = request.GET.get('activityId')
		ns = News.objects.filter(initiator = user, id = nsid)
		if ns:
			ns.update(is_finish = True)
			responsedata['status'] = 0
		else:
			responsedata['status'] = -2
			responsedata['error'] = 'you can not close this activity, you may not be the initiator'
	else:
		responsedata['status'] = -1
		responsedata['error'] = 'no cookies'
	return HttpResponse(json.dumps(responsedata),content_type="application/json")

def getMyRequestAllRelation(request):
	responsedata = {}
	relationList = []
	username = request.session.get("username")
	if username:
		activityId = request.GET.get("activityId")
		paticipator = User.objects.get(username = username)
		news = News.objects.filter(id = activityId)
		tmp = {}
		tmp['personInId'] = news[0].initiator.id
		tmp['personInAvatar'] = news[0].initiator.avatar.url
		tmp['personInNickname'] = news[0].initiator.nickname
		tmp['postTime'] = news[0].postTime.strftime("%Y-%m-%d %H:%M") 
		tmp['desc'] = news[0].initiator.desc
		tmp['sex'] = news[0].initiator.sex
		tmp['tag'] = []
		tagss = news[0].initiator.tag.all()
		for tag in tagss:
			tmp['tag'].append(tag.tag)
		hascommit = news[0].initiator.tag.filter(news = news[0], commitor = paticipator)
		if hascommit:
			tmp['commit'] = True
			tmp['giveRose'] = hascommit[0].giveRose
		else:
			tmp['commit'] = False
			tmp['giveRose'] = False
		responsedata['initiator'] = tmp
		if news:
			relations = news[0].relation.filter(result = True)
			if relations:
				for relation in relations:
					tmp = {}
					tmp['personInId'] = relation.user.id
					tmp['personInAvatar'] = relation.user.avatar.url
					tmp['personInNickname'] = relation.user.nickname
					tmp['postTime'] = relation.postTime.strftime("%Y-%m-%d %H:%M") 
					tmp['desc'] = relation.user.desc
					tmp['sex'] = relation.user.sex
					tmp['tag'] = []
					tagss = relation.user.tag.all()
					for tag in tagss:
						tmp['tag'].append(tag.tag)
					if relation.user == paticipator:
						tmp['commit'] = True
						tmp['giveRose'] = False
					else:
						tag = Tag.objects.filter(news = news, commitor = paticipator)
						if tag:
							if relation.user in tag[0].beCommitted.all():
								tmp['commit'] = True
								tmp['giveRose'] = tag[0].giveRose
							else:
								tmp['commit'] = False
								tmp['giveRose'] = False
						else:
							tmp['commit'] = False
							tmp['giveRose'] = False
					relationList.append(tmp)
				responsedata['num'] = len(relations) + 1
			else:
				responsedata['num'] = 1
			responsedata['relationList'] = relationList
			responsedata['status'] = 0
		else:
			responsedata['status'] = -2
			responsedata['error'] = 'error activity info'
	else:
		responsedata['status'] = -1
		responsedata['error'] = 'no cookies'
	return HttpResponse(json.dumps(responsedata,ensure_ascii=False,cls=DjangoJSONEncoder), content_type='application/json;charset=utf-8')

@csrf_exempt
def commit(request):
	responsedata = {}
	username = request.session.get('username')
	if username:
		activityId = request.POST.get("activityId")
		activity = News.objects.get(id = activityId)
		if activity.is_finish == False:
			responsedata['status'] = -2
			responsedata['error'] = 'this activity is not finished'
		else:
			commitor = User.objects.get(username = username)
			tag = request.POST.get('tag')
			giveRose = request.POST.get('giveRose')
			if giveRose.lower() == 'true' or giveRose == True:
				giveRose = True
			else:
				giveRose = False
			beCommittedId = request.POST.get('beCommittedId')
			beCommitted = User.objects.get(id = beCommittedId)
			hascommit = beCommitted.tag.filter(commitor = commitor, news = activity)
			if hascommit:
				responsedata['status'] = -3
				responsedata['error'] = 'already has committed'
			else:
				commit = Tag(commitor = commitor, news = activity,giveRose = giveRose,tag = tag)
				commit.save()
				if giveRose == True:
					beCommitted.rose = beCommitted.rose + 1
					beCommitted.save()
				beCommitted.tag.add(commit)
				responsedata['status'] = 0
	else:
		responsedata['status'] = -1
		responsedata['error'] = 'no cookies'
	return HttpResponse(json.dumps(responsedata),content_type="application/json")

def userInfo(request):
	responsedata = {}
	userId = request.GET.get('userId')
	if userId:
		user = User.objects.filter(id = userId)
		if user:
			user = user[0]
			userInfo = {}
			userInfo['avatar'] = user.avatar.url
			userInfo['nickname'] = user.nickname
			userInfo['sex'] = user.sex
			userInfo['desc'] = user.desc
			userInfo['rose'] = user.rose
			userInfo['tag'] = []
			tags = user.tag.all()
			for tag in tags:
				userInfo['tag'].append(tag.tag)
			responsedata['status'] = 0
			responsedata['userInfo'] = userInfo
		else:
			responsedata['status'] = -1
			responsedata['error'] = 'user does not exists'
	else:
		responsedata['status'] = -2
		responsedata['error'] = 'please input userId'
	return HttpResponse(json.dumps(responsedata, ensure_ascii=False, cls=DjangoJSONEncoder), content_type='application/json;charset=utf-8')


def getMyGroupTel(request):
	responsedata = {}
	username = request.session.get('username')
	if username:
		initiator = User.objects.get(username = username)
		activityId = request.GET.get('activityId')
		personInId = request.GET.get('personInId')
		paticipator = User.objects.get(id = personInId)
		news = News.objects.filter(id = activityId, initiator = initiator)
		if news:
			relation = news[0].relation.filter(user = paticipator)
			if relation:
				responsedata['status'] = 0
				responsedata['tel'] = relation[0].user.qq
			else:
				responsedata['status'] = -3
				responsedata['error'] = 'this person is not in this relation'
		else:
			responsedata['status'] = -2
			responsedata['error'] = 'you are not the initiator of this activity'
	else:
		responsedata['status'] = -1
		responsedata['error'] = 'no cookies'
	return HttpResponse(json.dumps(responsedata),content_type="application/json")

def getInitiatorTel(request):
	responsedata = {}
	username = request.session.get('username')
	if username:
		paticipator = User.objects.get(username = username)
		activityId = request.GET.get('activityId')
		news = News.objects.filter(id = activityId)
		if news[0].relation.filter(user = paticipator):
			responsedata['status'] = 0
			responsedata['tel'] = news[0].initiator.qq
		else:
			responsedata['status'] = -2
			responsedata['error'] = 'you are not in this activity'
	else:
		responsedata['status'] = -1
		responsedata['error'] = 'no cookies'
	return HttpResponse(json.dumps(responsedata),content_type="application/json")

