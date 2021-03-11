import 'package:flt_im_plugin/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_geen/views/pages/chat/view/message/audio.dart';
import 'package:flutter_geen/views/pages/chat/view/message/image.dart';
import 'package:flutter_geen/views/pages/chat/view/message/text.dart';
import 'package:flutter_geen/views/pages/chat/view/message/video.dart';

import 'ImMessage.dart';


const int MessageLeftAlign = 1;
const int MessageRightAlign = 2;

//压缩图片，图片对flutter内存的影响很大，压缩防止崩溃
const String ImageSize = '?imageView2/2/w/200/h/200';


/*
 * 单条消息 
 */
class ImMessageItemView extends StatefulWidget {
  final String avatarUrl;
  final Color color;
  final Message message;
  final int messageAlign;

  ImMessageItemView(
      {Key key,
      this.avatarUrl,
      this.color = const Color(0xfffdd82c),
      this.message,
      this.messageAlign = MessageLeftAlign})
      : super(key: key);

  @override
  _ImMessageItemViewState createState() => _ImMessageItemViewState();
}

class _ImMessageItemViewState extends State<ImMessageItemView> {
  @override
  Widget build(BuildContext context) {
    return _messageView(context);
  }

  Widget _messageView(BuildContext context) {
    if (widget.message.type == MessageType.MESSAGE_TEXT) {
      return TextMessage(
        message: widget.message,
        messageAlign: widget.messageAlign,
        color: widget.color,
        avatarUrl: widget.avatarUrl,
      );
    } else if (widget.message.type == MessageType.MESSAGE_IMAGE) {
      return ImageMessage(
        message: widget.message,
        messageAlign: widget.messageAlign,
        color: widget.color,
        avatarUrl: widget.avatarUrl,
      );
    } else if (widget.message.type == MessageType.MESSAGE_AUDIO) {
      return AudioMessage(
        message: widget.message,
        messageAlign: widget.messageAlign,
        color: widget.color,
        avatarUrl: widget.avatarUrl,
      );
    } else if (widget.message.type == MessageType.MESSAGE_VIDEO) {
      return VideoMessage(
        message: widget.message,
        messageAlign: widget.messageAlign,
        color: widget.color,
        avatarUrl: widget.avatarUrl,
      );
    }
    return SizedBox();
  }
}
