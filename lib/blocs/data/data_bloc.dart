import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/api/issues_api.dart';
import 'package:flutter_geen/generated/json/big_datas_entity_helper.dart';
import '../../big_datas_entity.dart';
import 'data_event.dart';
import 'data_state.dart';



class DataBloc extends Bloc<DataEvent, DataState> {


  DataBloc();

  @override
  DataState get initialState => DataInitals();


  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is DataInitals) {



    }
    if (event is EventGetData) {

      try {
        BigDatasEntity big = BigDatasEntity();
        var result= await IssuesApi.getData();
        if  (result['code']==200){

          bigDatasEntityFromJson(big,result);


        } else{

        }

        yield GetDataSuccess(big);

      } catch (err) {
        print(err);

      }

    }



  }


}
