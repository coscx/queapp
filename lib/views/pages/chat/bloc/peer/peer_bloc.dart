import 'dart:math';
import 'dart:io';
import 'package:flt_im_plugin/flt_im_plugin.dart';
import 'package:flt_im_plugin/message.dart';
import 'package:flt_im_plugin/value_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/res/cons.dart';
import 'package:flutter_geen/views/pages/chat/utils/encrypt.dart';
import 'peer_event.dart';
import 'peer_state.dart';



class PeerBloc extends Bloc<PeerEvent, PeerState> {


  PeerBloc();

  @override
  PeerState get initialState => PeerInital();

  Color get activeHomeColor {
    return Color(Cons.tabColors[0]);
  }

  @override
  Stream<PeerState> mapEventToState(PeerEvent event) async* {
    if (event is PeerInital) {


    }

    if (event is EventSendNewMessage) {
        FltImPlugin im = FltImPlugin();
        Map result = await im.sendTextMessage(
          secret: false,
          sender: event.currentUID,
          receiver: event.peerUID,
          rawContent: encrypt.aes_enc(event.content) ?? 'hello world',
        );
          List<Message> newMessage =[];
          Map response = await im.loadData();
          var  messages = ValueUtil.toArr(response["data"]).map((e) => Message.fromMap((e))).toList();
          newMessage.addAll(messages.reversed.toList());
          newMessage.map((e) {
          e.content['text'] = encrypt.aes_dec(e.content['text']);
          return e;
        }).toList();
        List<Message> newMessageList =[];
        for(var i=0; i< newMessage.length;i++){
          if (i == 0){
               newMessage[i].flags = 1;
               newMessageList.add(newMessage[i]);
            }else{
              newMessageList.add(newMessage[i]);
           }
        }

        yield PeerMessageSuccess(newMessageList,event.peerUID);
      }
    if (event is EventSendPeerRevokeMessage) {
      FltImPlugin im = FltImPlugin();
      Map result = await im.sendRevokeMessage(
        secret: false,
        sender: event.currentUID,
        receiver: event.peerUID,
        uuid:  event.msg,
      );
      List<Message> newMessage =[];
      Map response = await im.loadData();
      var  messages = ValueUtil.toArr(response["data"]).map((e) => Message.fromMap((e))).toList();
      newMessage.addAll(messages.reversed.toList());
      newMessage.map((e) {
        e.content['text'] = encrypt.aes_dec(e.content['text']);
        return e;
      }).toList();
      List<Message> newMessageList =[];
      // for(var i=0; i< newMessage.length;i++){
      //   if (i == 0){
      //     newMessage[i].flags = 1;
      //     newMessageList.add(newMessage[i]);
      //   }else{
      //     newMessageList.add(newMessage[i]);
      //   }
      // }

      yield PeerMessageSuccess(newMessage,event.peerUID);
    }
    if (event is EventSendNewVoiceMessage) {
      FltImPlugin im = FltImPlugin();
      Map result = await im.sendAudioMessage(
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
      List<Message> newMessageList =[];
      for(var i=0; i< newMessage.length;i++){
        if (i == 0){
          newMessage[i].flags = 1;
          newMessageList.add(newMessage[i]);
        }else{
          newMessageList.add(newMessage[i]);
        }
      }
      yield PeerMessageSuccess(newMessage,event.peerUID);
    }

    if (event is EventSendNewImageMessage) {
      FltImPlugin im = FltImPlugin();
      Map result = await im.sendImageMessage(
        secret: false,
        sender: event.currentUID,
        receiver: event.peerUID,
        image: event.content,
      );
      List<Message> newMessage =[];
      Map response = await im.loadData();
      var  messages = ValueUtil.toArr(response["data"]).map((e) => Message.fromMap((e))).toList();

      newMessage.addAll(messages.reversed.toList());
      newMessage.map((e) {
        e.content['text'] = encrypt.aes_dec(e.content['text']);
        return e;
      }).toList();
      List<Message> newMessageList =[];
      for(var i=0; i< newMessage.length;i++){
        if (i == 0){
          newMessage[i].flags = 1;
          newMessageList.add(newMessage[i]);
        }else{
          newMessageList.add(newMessage[i]);
        }
      }
      yield PeerMessageSuccess(newMessage,event.peerUID);
    }
    if (event is EventDeleteMessage) {
      FltImPlugin im = FltImPlugin();
      List<Message> oldMessage =state.props.elementAt(0);
      var peerUID =state.props.elementAt(1);
      List<Message> newMessage =[];
      // Map response = await im.loadData();
      // var  messages = ValueUtil.toArr(response["data"]).map((e) => Message.fromMap((e))).toList();
      oldMessage.forEach((e) {

        if (Platform.isAndroid == true) {
          if(e.content["uUID"]==event.currentUID){
            print(e.content["uUID"]);
          }else{
            e.content['text'] = encrypt.aes_dec(e.content['text']);
            newMessage.add(e);
          }
        }else{
          if(e.content["uuid"]==event.currentUID){
            print(e.content["uuid"]);
          }else{
            e.content['text'] = encrypt.aes_dec(e.content['text']);
            newMessage.add(e);
          }
        }


      });

      yield PeerMessageSuccess(newMessage,"0");
    }
    if (event is EventReceiveNewMessage) {

      try {
          String cunrrentId;
          List<Message> newMessage =[];
          if (state is PeerMessageSuccess){
            Message mess =Message.fromMap(event.message);
            cunrrentId= state.props.elementAt(1);

            if (cunrrentId != null && mess.sender!=cunrrentId){
              List<Message> history=state.props.elementAt(0);
              newMessage.addAll(history);
            }else{
              List<Message> history=state.props.elementAt(0);
              if(mess.type == MessageType.MESSAGE_REVOKE){
                FltImPlugin im = FltImPlugin();
                Map response = await im.loadData();
                var  messages = ValueUtil.toArr(response["data"]).map((e) => Message.fromMap((e))).toList();

                newMessage.addAll(messages.reversed.toList());
              }else{
                newMessage.add(mess);
                newMessage.addAll(history);
              }

            }

          } else if (state is LoadMorePeerMessageSuccess){
              FltImPlugin im = FltImPlugin();
              var res = await im.createConversion(
                currentUID: event.message['receiver'].toString(),
                peerUID: event.message['sender'].toString(),
              );
              cunrrentId=event.message['sender'].toString();
              Map response = await im.loadData();
              var  messages = ValueUtil.toArr(response["data"]).map((e) => Message.fromMap((e))).toList();

              newMessage.addAll(messages.reversed.toList());

          } else{
            FltImPlugin im = FltImPlugin();
            var res = await im.createConversion(
              currentUID: event.message['receiver'].toString(),
              peerUID: event.message['sender'].toString(),
            );
            Map response = await im.loadData();
            var  messages = ValueUtil.toArr(response["data"]).map((e) => Message.fromMap((e))).toList();

            newMessage.addAll(messages.reversed.toList());
          }

          newMessage.map((e) {
            e.content['text'] = encrypt.aes_dec(e.content['text']);
            return e;
          }).toList();
        yield PeerMessageSuccess(newMessage,cunrrentId);
      } catch (err) {
        print(err);
        yield GetPeerFailed();
      }

    }
    if (event is EventReceiveNewMessageAck) {

      try {

          String cunrrentId;
          List<Message> newMessage =[];
          FltImPlugin im = FltImPlugin();
          var res = await im.createConversion(
            currentUID: event.message['sender'].toString(),
            peerUID: event.message['receiver'].toString(),
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

          newMessages.map((e) {
            if(e.type==MessageType.MESSAGE_TEXT){
              e.content['text'] = encrypt.aes_dec(e.content['text']);
              return e;
            }else{
              return e;
            }

          }).toList();
        yield PeerMessageSuccess(newMessage,cunrrentId);
      } catch (err) {
        print(err);
        yield GetPeerFailed();
      }

    }

    if (event is EventFirstLoadMessage) {


      try {
        Map<String,dynamic> messageMap ={};
          FltImPlugin im = FltImPlugin();
          var res = await im.createConversion(
            currentUID: event.currentUID,
            peerUID: event.peerUID,
          );
          Map response = await im.loadData();
          var  messages = ValueUtil.toArr(response["data"]).map((e) => Message.fromMap(ValueUtil.toMap(e))).toList().reversed.toList();
        messages.map((e) {
          e.content['text'] = encrypt.aes_dec(e.content['text']);
        return e;
        }).toList();
        yield PeerMessageSuccess(messages,event.peerUID);
      } catch (err) {
        print(err);
        yield GetPeerFailed();
      }

    }
    if (event is EventLoadMoreMessage) {

      try {
           String LocalId ="0";
           List<Message> newMessages=[] ;
           FltImPlugin im = FltImPlugin();
           Map response;
           bool noMore =false;
          List<Message> history=[];
          if (state is PeerMessageSuccess){

            history=state.props.elementAt(0);
            LocalId= history.last.msgLocalID.toString();
            response = await im.loadEarlierData( messageID: LocalId);
          }else{

            if (state is LoadMorePeerMessageSuccess){

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
           newMessages.map((e) {
             e.content['text'] = encrypt.aes_dec(e.content['text']);
             return e;
           }).toList();
        yield LoadMorePeerMessageSuccess(newMessages,noMore);
      } catch (err) {
        print(err);
        yield GetPeerFailed();
      }

    }
  }


}
