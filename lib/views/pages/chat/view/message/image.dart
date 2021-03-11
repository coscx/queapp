import 'dart:io';
import 'package:flt_im_plugin/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_geen/views/pages/chat/view/gallery/photo.dart';
import 'package:flutter_geen/views/pages/chat/view/util/message.dart';


import '../util/ImMessage.dart';
import '../util/avatar.dart';

class ImageMessage extends StatefulWidget {
  final Message message;
  final int messageAlign;
  final String avatarUrl;
  final Color color;

  ImageMessage(
      {Key key, this.message, this.messageAlign, this.avatarUrl, this.color})
      : super(key: key);

  @override
  _ImageMessageState createState() => _ImageMessageState();
}

class _ImageMessageState extends State<ImageMessage> {
  @override
  Widget build(BuildContext context) {
    return _buildImageMessage(context);
  }

  Widget _buildImageMessage(BuildContext context) {
    if (widget.messageAlign == MessageLeftAlign) {
      return Container(
        margin: const EdgeInsets.only(left: 10, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: ImAvatar(
                avatarUrl: widget.avatarUrl,
              ),
            ),
            GestureDetector(
              onTap: () => _pushToFullImage(context, widget.message.rawContent),
              child: Container(
                height: 200,
                width: 200,
                margin: const EdgeInsets.only(bottom: 10, left: 4),
                child: Image(
                  image: widget.message.rawContent.contains("http")
                      ? NetworkImage(widget.message.rawContent + ImageSize)
                      : FileImage(File(widget.message.rawContent)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => _pushToFullImage(context, widget.message.rawContent),
        child: Container(
          margin: const EdgeInsets.only(right: 10, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                height: 200,
                width: 200,
                margin: const EdgeInsets.only(bottom: 10, right: 4),
                child: Image(
                  image: widget.message.rawContent.contains("http")
                      ? NetworkImage(widget.message.rawContent + ImageSize)
                      : FileImage(File(widget.message.rawContent)),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                child: ImAvatar(avatarUrl: widget.avatarUrl),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _pushToFullImage(BuildContext context, String url) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MessageGalleryView(
                backgroundDecoration:
                    const BoxDecoration(color: Colors.black87),
                url: url)));
  }
}
