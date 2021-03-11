import 'package:flutter_geen/big_data_menu_entity.dart';

bigDataMenuEntityFromJson(BigDataMenuEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	if (json['data'] != null) {
		data.data = new List<BigDataMenuData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new BigDataMenuData().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> bigDataMenuEntityToJson(BigDataMenuEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['msg'] = entity.msg;
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	return data;
}

bigDataMenuDataFromJson(BigDataMenuData data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['single'] != null) {
		data.single = json['single']?.toInt();
	}
	if (json['boy'] != null) {
		data.boy = json['boy']?.toInt();
	}
	if (json['girl'] != null) {
		data.girl = json['girl']?.toInt();
	}
	if (json['color'] != null) {
		data.color = json['color']?.toInt();
	}
	if (json['url'] != null) {
		data.url = json['url']?.toString();
	}
	return data;
}

Map<String, dynamic> bigDataMenuDataToJson(BigDataMenuData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['single'] = entity.single;
	data['boy'] = entity.boy;
	data['girl'] = entity.girl;
	data['color'] = entity.color;
	data['url'] = entity.url;
	return data;
}