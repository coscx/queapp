import 'package:flutter_geen/generated/json/base/json_convert_content.dart';

class BigDatasEntity with JsonConvert<BigDatasEntity> {
	int code;
	String msg;
	List<BigDatasData> data;
}

class BigDatasData with JsonConvert<BigDatasData> {
	String name;
	int num;
	int single;
	int boy;
	int girl;
	int color;
}
