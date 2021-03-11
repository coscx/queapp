import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Brower extends StatefulWidget {
  final String url;

  const Brower({Key key, this.url}) : super(key: key);
  @override
  _BrowerState createState() => _BrowerState();
}

class _BrowerState extends State<Brower> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        centerTitle: true,
        title: Text("data"),
    ),
    body:  WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.white,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        title: Text('title'),
      ),
    ));
  }
}
