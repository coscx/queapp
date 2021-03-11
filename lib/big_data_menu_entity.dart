import 'package:flutter_geen/generated/json/base/json_convert_content.dart';

class BigDataMenuEntity with JsonConvert<BigDataMenuEntity> {
	int code;
	String msg;
	List<BigDataMenuData> data;
}

class BigDataMenuData with JsonConvert<BigDataMenuData> {
	String name;
	int single;
	int boy;
	int girl;
	int color;
	String url;
}
