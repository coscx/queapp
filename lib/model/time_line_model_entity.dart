import 'package:flutter_geen/generated/json/base/json_convert_content.dart';
import 'package:flutter_geen/generated/json/base/json_field.dart';

class TimeLineModelEntity with JsonConvert<TimeLineModelEntity> {
	int code;
	String msg;
	TimeLineModelData data;
}

class TimeLineModelData with JsonConvert<TimeLineModelData> {
	List<TimeLineModelDataTimeLine> timeLine;
}

class TimeLineModelDataTimeLine with JsonConvert<TimeLineModelDataTimeLine> {
	String flag;
	String name;
	String time;
	String content;
	String doodle;
	String icon;
	String iconBackground;
	TimeLineModelDataTimeLineUser user;
	TimeLineModelDataTimeLineMy my;
}

class TimeLineModelDataTimeLineUser with JsonConvert<TimeLineModelDataTimeLineUser> {
	int memberId;
	String userName;
	String password;
	String nickName;
	String tel;
	String wxId;
	String unionId;
	int isinvited;
	int isreadloveme;
	int isreadmylove;
	String email;
	String fbId;
	int sex;
	String born;
	int age;
	String moneys;
	String province;
	String city;
	String district;
	String lng;
	String lat;
	int checked;
	@JSONField(name: "checked_num")
	int checkedNum;
	String tag;
	String constellation;
	String intro;
	String img;
	String thumbimg;
	String work;
	int working;
	int stated;
	int lv;
	@JSONField(name: "level_id")
	int levelId;
	int languageId;
	String consume;
	int pair;
	int slide;
	int love;
	int comment;
	int facescore;
	int score;
	int commenttime;
	int creditnum;
	int status;
	int hidden;
	int distime;
	int timesd;
	int lastlogintime;
	int bbstime;
	String addressed;
	String face;
	int look;
	int jump;
	int isSex;
	int notice;
	int realface;
	int send;
	int push;
	int cancel;
	int cachetime;
	int slidetime;
	int freenum;
	int viewCount;
	int addtime;
	int checktime;
	int deltime;
	String imei;
	String token;
	@JSONField(name: "AppAuthorization")
	String appAuthorization;
	@JSONField(name: "registration_id")
	String registrationId;
	int device;
	String machine;
	String version;
	String endtime;
	String aliagreement;
	int agreestatus;
	int applestatus;
	int invites;
	int isAi;
	int isVerify;
	int numAi;
	String timeAi;
	int noAccost;
	int refuse;
}

class TimeLineModelDataTimeLineMy with JsonConvert<TimeLineModelDataTimeLineMy> {
	int memberId;
	String userName;
	String password;
	String nickName;
	String tel;
	String wxId;
	String unionId;
	int isinvited;
	int isreadloveme;
	int isreadmylove;
	String email;
	String fbId;
	int sex;
	String born;
	int age;
	String moneys;
	String province;
	String city;
	String district;
	String lng;
	String lat;
	int checked;
	@JSONField(name: "checked_num")
	int checkedNum;
	String tag;
	String constellation;
	String intro;
	String img;
	String thumbimg;
	String work;
	int working;
	int stated;
	int lv;
	@JSONField(name: "level_id")
	int levelId;
	int languageId;
	String consume;
	int pair;
	int slide;
	int love;
	int comment;
	int facescore;
	int score;
	int commenttime;
	int creditnum;
	int status;
	int hidden;
	int distime;
	int timesd;
	int lastlogintime;
	int bbstime;
	String addressed;
	String face;
	int look;
	int jump;
	int isSex;
	int notice;
	int realface;
	int send;
	int push;
	int cancel;
	int cachetime;
	int slidetime;
	int freenum;
	int viewCount;
	int addtime;
	int checktime;
	int deltime;
	String imei;
	String token;
	@JSONField(name: "AppAuthorization")
	String appAuthorization;
	@JSONField(name: "registration_id")
	String registrationId;
	int device;
	String machine;
	String version;
	String endtime;
	String aliagreement;
	int agreestatus;
	int applestatus;
	int invites;
	int isAi;
	int isVerify;
	int numAi;
	String timeAi;
	int noAccost;
	int refuse;
}
