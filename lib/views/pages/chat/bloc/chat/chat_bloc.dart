import 'dart:math';

import 'package:flt_im_plugin/conversion.dart';
import 'package:flt_im_plugin/flt_im_plugin.dart';
import 'package:flt_im_plugin/value_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/api/issues_api.dart';
import 'package:flutter_geen/app/enums.dart';
import 'package:flutter_geen/app/res/cons.dart';
import 'package:flutter_geen/repositories/itf/widget_repository.dart';
import 'package:flutter_geen/storage/dao/local_storage.dart';
import 'package:flutter_geen/views/pages/chat/utils/encrypt.dart';
import 'chat_event.dart';
import 'chat_state.dart';



class ChatBloc extends Bloc<ChatEvent, ChatState> {


  ChatBloc();

  @override
  ChatState get initialState => ChatInital();

  Color get activeHomeColor {
    return Color(Cons.tabColors[0]);
  }

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is EventNewMessage) {
        //Map<String,dynamic> message = event.message;

      try {
      //   var newUsers= users.where((element) =>
      //   element['memberId'] != user['memberId']
      //   ).toList();
      //   String reason;
      //   String checked;
      //   String score;
      //   String type;
      //   reason="已撤回该用户"; checked="1";score="60";type="6";
      //
      //
      //   var result= await IssuesApi.checkUser(user['memberId'].toString(), checked,type,score);
      //   if  (result['code']==200){
      //
      //
      //   } else{
      //
      //   }
          FltImPlugin im = FltImPlugin();
          Map response = await im.getConversations();
          var  conversions = ValueUtil.toArr(response["data"]).map((e) => Conversion.fromMap(ValueUtil.toMap(e))).toList();
          conversions.map((e) {
            e.detail= encrypt.aes_dec(e.detail);
            return e;
          }).toList();
        yield ChatMessageSuccess(conversions);
      } catch (err) {
        print(err);
        yield GetChatFailed();
      }

    }
    if (event is EventFreshMessage) {

      try {
        FltImPlugin im = FltImPlugin();
        Map response = await im.getConversations();
        var  conversions = ValueUtil.toArr(response["data"]).map((e) => Conversion.fromMap(ValueUtil.toMap(e))).toList();
        conversions.map((e) {
          e.detail= encrypt.aes_dec(e.detail);
          return e;
        }).toList();
        yield ChatMessageSuccess(conversions);
      } catch (err) {
        print(err);
        yield GetChatFailed();
      }

    }
  }


}
