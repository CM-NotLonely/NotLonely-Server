import urllib2
import urllib
def user_auth(stuid, password):
	data = {
		'IDToken0':'',
		'IDToken1':stuid,
		'IDToken2':password,
		'IDButton':'Submit',
		'encoded':'true',
		'gx_charset':'UTF-8',
		'goto':'aHR0cDovL3BvcnRhbC51ZXN0Yy5lZHUuY24vbG9naW4ucG9ydGFs'
	}
	re = post('https://uis.uestc.edu.cn/amserver/UI/Login?goto=http%3A%2F%2Fportal.uestc.edu.cn%2Flogin.portal',data);
	if(re.find('Authentication is Successful')!=-1):
		return 0
	else:
		return -1

def post(url, data):  
    req = urllib2.Request(url)  
    data = urllib.urlencode(data)  
    #enable cookie  
    opener = urllib2.build_opener(urllib2.HTTPCookieProcessor())  
    response = opener.open(req, data)  
    return response.read()  

