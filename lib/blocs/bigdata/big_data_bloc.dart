import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/api/issues_api.dart';
import 'package:flutter_geen/generated/json/big_data_menu_entity_helper.dart';
import 'package:flutter_geen/generated/json/big_datas_entity_helper.dart';
import '../../big_data_menu_entity.dart';
import '../../big_datas_entity.dart';
import 'big_data_event.dart';
import 'big_data_state.dart';



class BigDataBloc extends Bloc<BigDataEvent, BigDataState> {


  BigDataBloc();

  @override
  BigDataState get initialState => BigDataInitals();


  @override
  Stream<BigDataState> mapEventToState(BigDataEvent event) async* {
    if (event is BigDataInitals) {



    }
    if (event is EventGetBigData) {

      try {
        BigDataMenuEntity big = BigDataMenuEntity();
        var result= await IssuesApi.getBigData();
        if  (result['code']==200){

          bigDataMenuEntityFromJson(big,result);


        } else{

        }

        yield GetBigDataSuccess(big);

      } catch (err) {
        print(err);

      }

    }



  }


}
