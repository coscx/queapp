import 'dart:math';

import 'package:flt_im_plugin/flt_im_plugin.dart';
import 'package:flt_im_plugin/message.dart';
import 'package:flt_im_plugin/value_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/res/cons.dart';
import 'group_event.dart';
import 'group_state.dart';



class GroupBloc extends Bloc<GroupEvent, GroupState> {


  GroupBloc();

  @override
  GroupState get initialState => GroupInital();

  Color get activeHomeColor {
    return Color(Cons.tabColors[0]);
  }

  @override
  Stream<GroupState> mapEventToState(GroupEvent event) async* {
    if (event is GroupInital) {


    }

    if (event is EventGroupSendNewMessage) {
        FltImPlugin im = FltImPlugin();
        Map result = await im.sendGroupTextMessage(
          secret: false,
          sender: event.currentUID,
          receiver: event.GroupUID,
          rawContent: event.content ?? 'hello world',
        );
          List<Message> newMessage =[];
          Map response = await im.loadData();
          var  messages = ValueUtil.toArr(response["data"]).map((e) => Message.fromMap((e))).toList();

          newMessage.addAll(messages.reversed.toList());

        yield GroupMessageSuccess(newMessage,event.GroupUID);
      }
    if (event is EventGroupSendNewImageMessage) {
      FltImPlugin im = FltImPlugin();
      Map result = await im.sendGroupImageMessage(
        secret: false,
        sender: event.currentUID,
        receiver: event.GroupUID,
        image: event.content,
      );
      List<Message> newMessage =[];
      Map response = await im.loadData();
      var  messages = ValueUtil.toArr(response["data"]).map((e) => Message.fromMap((e))).toList();

      newMessage.addAll(messages.reversed.toList());

      yield GroupMessageSuccess(newMessage,event.GroupUID);
    }
    if (event is EventGroupReceiveNewMessage) {

      try {

          String cunrrentId;
          List<Message> newMessage =[];
          if (state is GroupMessageSuccess){
            Message mess =Message.fromMap(event.message);
            cunrrentId= state.props.elementAt(1);
            if (cunrrentId ==null){
              cunrrentId= mess.receiver;
            }
            if (cunrrentId == null && mess.sender!=cunrrentId){
              List<Message> history=state.props.elementAt(0);
              newMessage.addAll(history);
            }else{
              List<Message> history=state.props.elementAt(0);
              newMessage.add(mess);
              newMessage.addAll(history);
            }


          } else if (state is LoadMoreGroupMessageSuccess){
              FltImPlugin im = FltImPlugin();
              var res = await im.createGroupConversion(
                currentUID: event.message['sender'].toString(),
                groupUID: event.message['receiver'].toString(),
              );
              cunrrentId=event.message['sender'].toString();
              Map response = await im.loadData();
              var  messages = ValueUtil.toArr(response["data"]).map((e) => Message.fromMap((e))).toList();

              newMessage.addAll(messages.reversed.toList());

          } else{
            FltImPlugin im = FltImPlugin();
            var res = await im.createGroupConversion(
              currentUID: event.message['receiver'].toString(),
              groupUID: event.message['sender'].toString(),
            );
            Map response = await im.loadData();
            var  messages = ValueUtil.toArr(response["data"]).map((e) => Message.fromMap((e))).toList();

            newMessage.addAll(messages.reversed.toList());
          }


        yield GroupMessageSuccess(newMessage,cunrrentId);
      } catch (err) {
        print(err);
        yield GetGroupFailed();
      }

    }
    if (event is EventGroupSendNewVoiceMessage) {
      FltImPlugin im = FltImPlugin();
      Map result = await im.sendGroupAudioMessage(
          secret: false,
          sender: event.currentUID,
          receiver: event.peerUID,
          path: event.path ??'',
          second: event.second
      );
      List<Message> newMessage =[];
      Map response = await im.loadData();
      var  messages = ValueUtil.toArr(response["data"]).map((e) => Message.fromMap((e))).toList();

      newMessage.addAll(messages.reversed.toList());

      yield GroupMessageSuccess(newMessage,event.peerUID);
    }
    if (event is EventGroupReceiveNewMessageAck) {

      try {

          String cunrrentId;
          List<Message> newMessage =[];
          FltImPlugin im = FltImPlugin();
          var res = await im.createGroupConversion(
            currentUID: event.message['sender'].toString(),
            groupUID: event.message['receiver'].toString(),
          );
          cunrrentId=event.message['receiver'].toString();
          Map response = await im.loadData();
          var  messages = ValueUtil.toArr(response["data"]).map((e) => Message.fromMap((e))).toList();
          var newMessages= messages.map((item) {
            if(item.msgLocalID == event.message['msgLocalID']){
              item.flags=2;
              return item;
            }else{
              return item;
            }

          }).toList();

        newMessage.addAll(newMessages.reversed.toList());
        yield GroupMessageSuccess(newMessage,cunrrentId);
      } catch (err) {
        print(err);
        yield GetGroupFailed();
      }

    }

    if (event is EventGroupFirstLoadMessage) {


      try {
        Map<String,dynamic> messageMap ={};
          FltImPlugin im = FltImPlugin();
          var res = await im.createGroupConversion(
            currentUID: event.currentUID,
            groupUID: event.GroupUID,
          );
          Map response = await im.loadData();
          var  messages = ValueUtil.toArr(response["data"]).map((e) => Message.fromMap(ValueUtil.toMap(e))).toList().reversed.toList();

        yield GroupMessageSuccess(messages,event.GroupUID);
      } catch (err) {
        print(err);
        yield GetGroupFailed();
      }

    }
    if (event is EventGroupLoadMoreMessage) {

      try {
           String LocalId ="0";
           List<Message> newMessages=[] ;
           FltImPlugin im = FltImPlugin();
           Map response;
           bool noMore =false;
          List<Message> history=[];
          if (state is GroupMessageSuccess){

            history=state.props.elementAt(0);
            LocalId= history.last.msgLocalID.toString();
            response = await im.loadEarlierData( messageID: LocalId);
          }else{

            if (state is LoadMoreGroupMessageSuccess){

              history=state.props.elementAt(0);
              LocalId= history.last.msgLocalID.toString();
              response = await im.loadEarlierData( messageID: LocalId);
            }else{
              response = await im.loadData();
            }


          }

          var  messages = ValueUtil.toArr(response["data"]).map((e) => Message.fromMap(ValueUtil.toMap(e))).toList().reversed.toList();
          if (messages.length==0){
            noMore=true;
          }
          if(history.last!=null){
            newMessages.addAll(history);
            newMessages.addAll(messages);
          }else{

            newMessages.addAll(messages);
          }

        yield LoadMoreGroupMessageSuccess(newMessages,noMore);
      } catch (err) {
        print(err);
        yield GetGroupFailed();
      }

    }
  }


}
