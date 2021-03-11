import 'package:flutter_geen/model/time_line_model_entity.dart';

timeLineModelEntityFromJson(TimeLineModelEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	if (json['data'] != null) {
		data.data = new TimeLineModelData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> timeLineModelEntityToJson(TimeLineModelEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['msg'] = entity.msg;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	return data;
}

timeLineModelDataFromJson(TimeLineModelData data, Map<String, dynamic> json) {
	if (json['timeLine'] != null) {
		data.timeLine = new List<TimeLineModelDataTimeLine>();
		(json['timeLine'] as List).forEach((v) {
			data.timeLine.add(new TimeLineModelDataTimeLine().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> timeLineModelDataToJson(TimeLineModelData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.timeLine != null) {
		data['timeLine'] =  entity.timeLine.map((v) => v.toJson()).toList();
	}
	return data;
}

timeLineModelDataTimeLineFromJson(TimeLineModelDataTimeLine data, Map<String, dynamic> json) {
	if (json['flag'] != null) {
		data.flag = json['flag']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['time'] != null) {
		data.time = json['time']?.toString();
	}
	if (json['content'] != null) {
		data.content = json['content']?.toString();
	}
	if (json['doodle'] != null) {
		data.doodle = json['doodle']?.toString();
	}
	if (json['icon'] != null) {
		data.icon = json['icon']?.toString();
	}
	if (json['iconBackground'] != null) {
		data.iconBackground = json['iconBackground']?.toString();
	}
	if (json['user'] != null) {
		data.user = new TimeLineModelDataTimeLineUser().fromJson(json['user']);
	}
	if (json['my'] != null) {
		data.my = new TimeLineModelDataTimeLineMy().fromJson(json['my']);
	}
	return data;
}

Map<String, dynamic> timeLineModelDataTimeLineToJson(TimeLineModelDataTimeLine entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['flag'] = entity.flag;
	data['name'] = entity.name;
	data['time'] = entity.time;
	data['content'] = entity.content;
	data['doodle'] = entity.doodle;
	data['icon'] = entity.icon;
	data['iconBackground'] = entity.iconBackground;
	if (entity.user != null) {
		data['user'] = entity.user.toJson();
	}
	if (entity.my != null) {
		data['my'] = entity.my.toJson();
	}
	return data;
}

timeLineModelDataTimeLineUserFromJson(TimeLineModelDataTimeLineUser data, Map<String, dynamic> json) {
	if (json['memberId'] != null) {
		data.memberId = json['memberId']?.toInt();
	}
	if (json['userName'] != null) {
		data.userName = json['userName']?.toString();
	}
	if (json['password'] != null) {
		data.password = json['password']?.toString();
	}
	if (json['nickName'] != null) {
		data.nickName = json['nickName']?.toString();
	}
	if (json['tel'] != null) {
		data.tel = json['tel']?.toString();
	}
	if (json['wxId'] != null) {
		data.wxId = json['wxId']?.toString();
	}
	if (json['unionId'] != null) {
		data.unionId = json['unionId']?.toString();
	}
	if (json['isinvited'] != null) {
		data.isinvited = json['isinvited']?.toInt();
	}
	if (json['isreadloveme'] != null) {
		data.isreadloveme = json['isreadloveme']?.toInt();
	}
	if (json['isreadmylove'] != null) {
		data.isreadmylove = json['isreadmylove']?.toInt();
	}
	if (json['email'] != null) {
		data.email = json['email']?.toString();
	}
	if (json['fbId'] != null) {
		data.fbId = json['fbId']?.toString();
	}
	if (json['sex'] != null) {
		data.sex = json['sex']?.toInt();
	}
	if (json['born'] != null) {
		data.born = json['born']?.toString();
	}
	if (json['age'] != null) {
		data.age = json['age']?.toInt();
	}
	if (json['moneys'] != null) {
		data.moneys = json['moneys']?.toString();
	}
	if (json['province'] != null) {
		data.province = json['province']?.toString();
	}
	if (json['city'] != null) {
		data.city = json['city']?.toString();
	}
	if (json['district'] != null) {
		data.district = json['district']?.toString();
	}
	if (json['lng'] != null) {
		data.lng = json['lng']?.toString();
	}
	if (json['lat'] != null) {
		data.lat = json['lat']?.toString();
	}
	if (json['checked'] != null) {
		data.checked = json['checked']?.toInt();
	}
	if (json['checked_num'] != null) {
		data.checkedNum = json['checked_num']?.toInt();
	}
	if (json['tag'] != null) {
		data.tag = json['tag']?.toString();
	}
	if (json['constellation'] != null) {
		data.constellation = json['constellation']?.toString();
	}
	if (json['intro'] != null) {
		data.intro = json['intro']?.toString();
	}
	if (json['img'] != null) {
		data.img = json['img']?.toString();
	}
	if (json['thumbimg'] != null) {
		data.thumbimg = json['thumbimg']?.toString();
	}
	if (json['work'] != null) {
		data.work = json['work']?.toString();
	}
	if (json['working'] != null) {
		data.working = json['working']?.toInt();
	}
	if (json['stated'] != null) {
		data.stated = json['stated']?.toInt();
	}
	if (json['lv'] != null) {
		data.lv = json['lv']?.toInt();
	}
	if (json['level_id'] != null) {
		data.levelId = json['level_id']?.toInt();
	}
	if (json['languageId'] != null) {
		data.languageId = json['languageId']?.toInt();
	}
	if (json['consume'] != null) {
		data.consume = json['consume']?.toString();
	}
	if (json['pair'] != null) {
		data.pair = json['pair']?.toInt();
	}
	if (json['slide'] != null) {
		data.slide = json['slide']?.toInt();
	}
	if (json['love'] != null) {
		data.love = json['love']?.toInt();
	}
	if (json['comment'] != null) {
		data.comment = json['comment']?.toInt();
	}
	if (json['facescore'] != null) {
		data.facescore = json['facescore']?.toInt();
	}
	if (json['score'] != null) {
		data.score = json['score']?.toInt();
	}
	if (json['commenttime'] != null) {
		data.commenttime = json['commenttime']?.toInt();
	}
	if (json['creditnum'] != null) {
		data.creditnum = json['creditnum']?.toInt();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	if (json['hidden'] != null) {
		data.hidden = json['hidden']?.toInt();
	}
	if (json['distime'] != null) {
		data.distime = json['distime']?.toInt();
	}
	if (json['timesd'] != null) {
		data.timesd = json['timesd']?.toInt();
	}
	if (json['lastlogintime'] != null) {
		data.lastlogintime = json['lastlogintime']?.toInt();
	}
	if (json['bbstime'] != null) {
		data.bbstime = json['bbstime']?.toInt();
	}
	if (json['addressed'] != null) {
		data.addressed = json['addressed']?.toString();
	}
	if (json['face'] != null) {
		data.face = json['face']?.toString();
	}
	if (json['look'] != null) {
		data.look = json['look']?.toInt();
	}
	if (json['jump'] != null) {
		data.jump = json['jump']?.toInt();
	}
	if (json['isSex'] != null) {
		data.isSex = json['isSex']?.toInt();
	}
	if (json['notice'] != null) {
		data.notice = json['notice']?.toInt();
	}
	if (json['realface'] != null) {
		data.realface = json['realface']?.toInt();
	}
	if (json['send'] != null) {
		data.send = json['send']?.toInt();
	}
	if (json['push'] != null) {
		data.push = json['push']?.toInt();
	}
	if (json['cancel'] != null) {
		data.cancel = json['cancel']?.toInt();
	}
	if (json['cachetime'] != null) {
		data.cachetime = json['cachetime']?.toInt();
	}
	if (json['slidetime'] != null) {
		data.slidetime = json['slidetime']?.toInt();
	}
	if (json['freenum'] != null) {
		data.freenum = json['freenum']?.toInt();
	}
	if (json['viewCount'] != null) {
		data.viewCount = json['viewCount']?.toInt();
	}
	if (json['addtime'] != null) {
		data.addtime = json['addtime']?.toInt();
	}
	if (json['checktime'] != null) {
		data.checktime = json['checktime']?.toInt();
	}
	if (json['deltime'] != null) {
		data.deltime = json['deltime']?.toInt();
	}
	if (json['imei'] != null) {
		data.imei = json['imei']?.toString();
	}
	if (json['token'] != null) {
		data.token = json['token']?.toString();
	}
	if (json['AppAuthorization'] != null) {
		data.appAuthorization = json['AppAuthorization']?.toString();
	}
	if (json['registration_id'] != null) {
		data.registrationId = json['registration_id']?.toString();
	}
	if (json['device'] != null) {
		data.device = json['device']?.toInt();
	}
	if (json['machine'] != null) {
		data.machine = json['machine']?.toString();
	}
	if (json['version'] != null) {
		data.version = json['version']?.toString();
	}
	if (json['endtime'] != null) {
		data.endtime = json['endtime']?.toString();
	}
	if (json['aliagreement'] != null) {
		data.aliagreement = json['aliagreement']?.toString();
	}
	if (json['agreestatus'] != null) {
		data.agreestatus = json['agreestatus']?.toInt();
	}
	if (json['applestatus'] != null) {
		data.applestatus = json['applestatus']?.toInt();
	}
	if (json['invites'] != null) {
		data.invites = json['invites']?.toInt();
	}
	if (json['isAi'] != null) {
		data.isAi = json['isAi']?.toInt();
	}
	if (json['isVerify'] != null) {
		data.isVerify = json['isVerify']?.toInt();
	}
	if (json['numAi'] != null) {
		data.numAi = json['numAi']?.toInt();
	}
	if (json['timeAi'] != null) {
		data.timeAi = json['timeAi']?.toString();
	}
	if (json['noAccost'] != null) {
		data.noAccost = json['noAccost']?.toInt();
	}
	if (json['refuse'] != null) {
		data.refuse = json['refuse']?.toInt();
	}
	return data;
}

Map<String, dynamic> timeLineModelDataTimeLineUserToJson(TimeLineModelDataTimeLineUser entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['memberId'] = entity.memberId;
	data['userName'] = entity.userName;
	data['password'] = entity.password;
	data['nickName'] = entity.nickName;
	data['tel'] = entity.tel;
	data['wxId'] = entity.wxId;
	data['unionId'] = entity.unionId;
	data['isinvited'] = entity.isinvited;
	data['isreadloveme'] = entity.isreadloveme;
	data['isreadmylove'] = entity.isreadmylove;
	data['email'] = entity.email;
	data['fbId'] = entity.fbId;
	data['sex'] = entity.sex;
	data['born'] = entity.born;
	data['age'] = entity.age;
	data['moneys'] = entity.moneys;
	data['province'] = entity.province;
	data['city'] = entity.city;
	data['district'] = entity.district;
	data['lng'] = entity.lng;
	data['lat'] = entity.lat;
	data['checked'] = entity.checked;
	data['checked_num'] = entity.checkedNum;
	data['tag'] = entity.tag;
	data['constellation'] = entity.constellation;
	data['intro'] = entity.intro;
	data['img'] = entity.img;
	data['thumbimg'] = entity.thumbimg;
	data['work'] = entity.work;
	data['working'] = entity.working;
	data['stated'] = entity.stated;
	data['lv'] = entity.lv;
	data['level_id'] = entity.levelId;
	data['languageId'] = entity.languageId;
	data['consume'] = entity.consume;
	data['pair'] = entity.pair;
	data['slide'] = entity.slide;
	data['love'] = entity.love;
	data['comment'] = entity.comment;
	data['facescore'] = entity.facescore;
	data['score'] = entity.score;
	data['commenttime'] = entity.commenttime;
	data['creditnum'] = entity.creditnum;
	data['status'] = entity.status;
	data['hidden'] = entity.hidden;
	data['distime'] = entity.distime;
	data['timesd'] = entity.timesd;
	data['lastlogintime'] = entity.lastlogintime;
	data['bbstime'] = entity.bbstime;
	data['addressed'] = entity.addressed;
	data['face'] = entity.face;
	data['look'] = entity.look;
	data['jump'] = entity.jump;
	data['isSex'] = entity.isSex;
	data['notice'] = entity.notice;
	data['realface'] = entity.realface;
	data['send'] = entity.send;
	data['push'] = entity.push;
	data['cancel'] = entity.cancel;
	data['cachetime'] = entity.cachetime;
	data['slidetime'] = entity.slidetime;
	data['freenum'] = entity.freenum;
	data['viewCount'] = entity.viewCount;
	data['addtime'] = entity.addtime;
	data['checktime'] = entity.checktime;
	data['deltime'] = entity.deltime;
	data['imei'] = entity.imei;
	data['token'] = entity.token;
	data['AppAuthorization'] = entity.appAuthorization;
	data['registration_id'] = entity.registrationId;
	data['device'] = entity.device;
	data['machine'] = entity.machine;
	data['version'] = entity.version;
	data['endtime'] = entity.endtime;
	data['aliagreement'] = entity.aliagreement;
	data['agreestatus'] = entity.agreestatus;
	data['applestatus'] = entity.applestatus;
	data['invites'] = entity.invites;
	data['isAi'] = entity.isAi;
	data['isVerify'] = entity.isVerify;
	data['numAi'] = entity.numAi;
	data['timeAi'] = entity.timeAi;
	data['noAccost'] = entity.noAccost;
	data['refuse'] = entity.refuse;
	return data;
}

timeLineModelDataTimeLineMyFromJson(TimeLineModelDataTimeLineMy data, Map<String, dynamic> json) {
	if (json['memberId'] != null) {
		data.memberId = json['memberId']?.toInt();
	}
	if (json['userName'] != null) {
		data.userName = json['userName']?.toString();
	}
	if (json['password'] != null) {
		data.password = json['password']?.toString();
	}
	if (json['nickName'] != null) {
		data.nickName = json['nickName']?.toString();
	}
	if (json['tel'] != null) {
		data.tel = json['tel']?.toString();
	}
	if (json['wxId'] != null) {
		data.wxId = json['wxId']?.toString();
	}
	if (json['unionId'] != null) {
		data.unionId = json['unionId']?.toString();
	}
	if (json['isinvited'] != null) {
		data.isinvited = json['isinvited']?.toInt();
	}
	if (json['isreadloveme'] != null) {
		data.isreadloveme = json['isreadloveme']?.toInt();
	}
	if (json['isreadmylove'] != null) {
		data.isreadmylove = json['isreadmylove']?.toInt();
	}
	if (json['email'] != null) {
		data.email = json['email']?.toString();
	}
	if (json['fbId'] != null) {
		data.fbId = json['fbId']?.toString();
	}
	if (json['sex'] != null) {
		data.sex = json['sex']?.toInt();
	}
	if (json['born'] != null) {
		data.born = json['born']?.toString();
	}
	if (json['age'] != null) {
		data.age = json['age']?.toInt();
	}
	if (json['moneys'] != null) {
		data.moneys = json['moneys']?.toString();
	}
	if (json['province'] != null) {
		data.province = json['province']?.toString();
	}
	if (json['city'] != null) {
		data.city = json['city']?.toString();
	}
	if (json['district'] != null) {
		data.district = json['district']?.toString();
	}
	if (json['lng'] != null) {
		data.lng = json['lng']?.toString();
	}
	if (json['lat'] != null) {
		data.lat = json['lat']?.toString();
	}
	if (json['checked'] != null) {
		data.checked = json['checked']?.toInt();
	}
	if (json['checked_num'] != null) {
		data.checkedNum = json['checked_num']?.toInt();
	}
	if (json['tag'] != null) {
		data.tag = json['tag']?.toString();
	}
	if (json['constellation'] != null) {
		data.constellation = json['constellation']?.toString();
	}
	if (json['intro'] != null) {
		data.intro = json['intro']?.toString();
	}
	if (json['img'] != null) {
		data.img = json['img']?.toString();
	}
	if (json['thumbimg'] != null) {
		data.thumbimg = json['thumbimg']?.toString();
	}
	if (json['work'] != null) {
		data.work = json['work']?.toString();
	}
	if (json['working'] != null) {
		data.working = json['working']?.toInt();
	}
	if (json['stated'] != null) {
		data.stated = json['stated']?.toInt();
	}
	if (json['lv'] != null) {
		data.lv = json['lv']?.toInt();
	}
	if (json['level_id'] != null) {
		data.levelId = json['level_id']?.toInt();
	}
	if (json['languageId'] != null) {
		data.languageId = json['languageId']?.toInt();
	}
	if (json['consume'] != null) {
		data.consume = json['consume']?.toString();
	}
	if (json['pair'] != null) {
		data.pair = json['pair']?.toInt();
	}
	if (json['slide'] != null) {
		data.slide = json['slide']?.toInt();
	}
	if (json['love'] != null) {
		data.love = json['love']?.toInt();
	}
	if (json['comment'] != null) {
		data.comment = json['comment']?.toInt();
	}
	if (json['facescore'] != null) {
		data.facescore = json['facescore']?.toInt();
	}
	if (json['score'] != null) {
		data.score = json['score']?.toInt();
	}
	if (json['commenttime'] != null) {
		data.commenttime = json['commenttime']?.toInt();
	}
	if (json['creditnum'] != null) {
		data.creditnum = json['creditnum']?.toInt();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	if (json['hidden'] != null) {
		data.hidden = json['hidden']?.toInt();
	}
	if (json['distime'] != null) {
		data.distime = json['distime']?.toInt();
	}
	if (json['timesd'] != null) {
		data.timesd = json['timesd']?.toInt();
	}
	if (json['lastlogintime'] != null) {
		data.lastlogintime = json['lastlogintime']?.toInt();
	}
	if (json['bbstime'] != null) {
		data.bbstime = json['bbstime']?.toInt();
	}
	if (json['addressed'] != null) {
		data.addressed = json['addressed']?.toString();
	}
	if (json['face'] != null) {
		data.face = json['face']?.toString();
	}
	if (json['look'] != null) {
		data.look = json['look']?.toInt();
	}
	if (json['jump'] != null) {
		data.jump = json['jump']?.toInt();
	}
	if (json['isSex'] != null) {
		data.isSex = json['isSex']?.toInt();
	}
	if (json['notice'] != null) {
		data.notice = json['notice']?.toInt();
	}
	if (json['realface'] != null) {
		data.realface = json['realface']?.toInt();
	}
	if (json['send'] != null) {
		data.send = json['send']?.toInt();
	}
	if (json['push'] != null) {
		data.push = json['push']?.toInt();
	}
	if (json['cancel'] != null) {
		data.cancel = json['cancel']?.toInt();
	}
	if (json['cachetime'] != null) {
		data.cachetime = json['cachetime']?.toInt();
	}
	if (json['slidetime'] != null) {
		data.slidetime = json['slidetime']?.toInt();
	}
	if (json['freenum'] != null) {
		data.freenum = json['freenum']?.toInt();
	}
	if (json['viewCount'] != null) {
		data.viewCount = json['viewCount']?.toInt();
	}
	if (json['addtime'] != null) {
		data.addtime = json['addtime']?.toInt();
	}
	if (json['checktime'] != null) {
		data.checktime = json['checktime']?.toInt();
	}
	if (json['deltime'] != null) {
		data.deltime = json['deltime']?.toInt();
	}
	if (json['imei'] != null) {
		data.imei = json['imei']?.toString();
	}
	if (json['token'] != null) {
		data.token = json['token']?.toString();
	}
	if (json['AppAuthorization'] != null) {
		data.appAuthorization = json['AppAuthorization']?.toString();
	}
	if (json['registration_id'] != null) {
		data.registrationId = json['registration_id']?.toString();
	}
	if (json['device'] != null) {
		data.device = json['device']?.toInt();
	}
	if (json['machine'] != null) {
		data.machine = json['machine']?.toString();
	}
	if (json['version'] != null) {
		data.version = json['version']?.toString();
	}
	if (json['endtime'] != null) {
		data.endtime = json['endtime']?.toString();
	}
	if (json['aliagreement'] != null) {
		data.aliagreement = json['aliagreement']?.toString();
	}
	if (json['agreestatus'] != null) {
		data.agreestatus = json['agreestatus']?.toInt();
	}
	if (json['applestatus'] != null) {
		data.applestatus = json['applestatus']?.toInt();
	}
	if (json['invites'] != null) {
		data.invites = json['invites']?.toInt();
	}
	if (json['isAi'] != null) {
		data.isAi = json['isAi']?.toInt();
	}
	if (json['isVerify'] != null) {
		data.isVerify = json['isVerify']?.toInt();
	}
	if (json['numAi'] != null) {
		data.numAi = json['numAi']?.toInt();
	}
	if (json['timeAi'] != null) {
		data.timeAi = json['timeAi']?.toString();
	}
	if (json['noAccost'] != null) {
		data.noAccost = json['noAccost']?.toInt();
	}
	if (json['refuse'] != null) {
		data.refuse = json['refuse']?.toInt();
	}
	return data;
}

Map<String, dynamic> timeLineModelDataTimeLineMyToJson(TimeLineModelDataTimeLineMy entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['memberId'] = entity.memberId;
	data['userName'] = entity.userName;
	data['password'] = entity.password;
	data['nickName'] = entity.nickName;
	data['tel'] = entity.tel;
	data['wxId'] = entity.wxId;
	data['unionId'] = entity.unionId;
	data['isinvited'] = entity.isinvited;
	data['isreadloveme'] = entity.isreadloveme;
	data['isreadmylove'] = entity.isreadmylove;
	data['email'] = entity.email;
	data['fbId'] = entity.fbId;
	data['sex'] = entity.sex;
	data['born'] = entity.born;
	data['age'] = entity.age;
	data['moneys'] = entity.moneys;
	data['province'] = entity.province;
	data['city'] = entity.city;
	data['district'] = entity.district;
	data['lng'] = entity.lng;
	data['lat'] = entity.lat;
	data['checked'] = entity.checked;
	data['checked_num'] = entity.checkedNum;
	data['tag'] = entity.tag;
	data['constellation'] = entity.constellation;
	data['intro'] = entity.intro;
	data['img'] = entity.img;
	data['thumbimg'] = entity.thumbimg;
	data['work'] = entity.work;
	data['working'] = entity.working;
	data['stated'] = entity.stated;
	data['lv'] = entity.lv;
	data['level_id'] = entity.levelId;
	data['languageId'] = entity.languageId;
	data['consume'] = entity.consume;
	data['pair'] = entity.pair;
	data['slide'] = entity.slide;
	data['love'] = entity.love;
	data['comment'] = entity.comment;
	data['facescore'] = entity.facescore;
	data['score'] = entity.score;
	data['commenttime'] = entity.commenttime;
	data['creditnum'] = entity.creditnum;
	data['status'] = entity.status;
	data['hidden'] = entity.hidden;
	data['distime'] = entity.distime;
	data['timesd'] = entity.timesd;
	data['lastlogintime'] = entity.lastlogintime;
	data['bbstime'] = entity.bbstime;
	data['addressed'] = entity.addressed;
	data['face'] = entity.face;
	data['look'] = entity.look;
	data['jump'] = entity.jump;
	data['isSex'] = entity.isSex;
	data['notice'] = entity.notice;
	data['realface'] = entity.realface;
	data['send'] = entity.send;
	data['push'] = entity.push;
	data['cancel'] = entity.cancel;
	data['cachetime'] = entity.cachetime;
	data['slidetime'] = entity.slidetime;
	data['freenum'] = entity.freenum;
	data['viewCount'] = entity.viewCount;
	data['addtime'] = entity.addtime;
	data['checktime'] = entity.checktime;
	data['deltime'] = entity.deltime;
	data['imei'] = entity.imei;
	data['token'] = entity.token;
	data['AppAuthorization'] = entity.appAuthorization;
	data['registration_id'] = entity.registrationId;
	data['device'] = entity.device;
	data['machine'] = entity.machine;
	data['version'] = entity.version;
	data['endtime'] = entity.endtime;
	data['aliagreement'] = entity.aliagreement;
	data['agreestatus'] = entity.agreestatus;
	data['applestatus'] = entity.applestatus;
	data['invites'] = entity.invites;
	data['isAi'] = entity.isAi;
	data['isVerify'] = entity.isVerify;
	data['numAi'] = entity.numAi;
	data['timeAi'] = entity.timeAi;
	data['noAccost'] = entity.noAccost;
	data['refuse'] = entity.refuse;
	return data;
}