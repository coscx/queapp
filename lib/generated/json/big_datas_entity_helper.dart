import 'package:flutter_geen/big_datas_entity.dart';

bigDatasEntityFromJson(BigDatasEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	if (json['data'] != null) {
		data.data = new List<BigDatasData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new BigDatasData().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> bigDatasEntityToJson(BigDatasEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['msg'] = entity.msg;
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	return data;
}

bigDatasDataFromJson(BigDatasData data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['num'] != null) {
		data.num = json['num']?.toInt();
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
	return data;
}

Map<String, dynamic> bigDatasDataToJson(BigDatasData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['num'] = entity.num;
	data['single'] = entity.single;
	data['boy'] = entity.boy;
	data['girl'] = entity.girl;
	data['color'] = entity.color;
	return data;
}