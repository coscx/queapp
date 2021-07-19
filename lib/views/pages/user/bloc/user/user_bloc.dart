import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/api/issues_api.dart';
import 'user_event.dart';
import 'user_state.dart';



class UserBloc extends Bloc<UserEvent, UserState> {


  UserBloc();

  @override
  UserState get initialState => UserInitals();


  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserInitals) {
    }
    if (event is EventGetUser) {

      try {
        var data={};
        var result= await IssuesApi.getUser("1");
        if  (result['code']==200){

          data =result['data'];


        } else{

        }

        yield GetUserSuccess(data);

      } catch (err) {
        print(err);

      }

    }



  }


}
