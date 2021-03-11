import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_qr_reader/qrcode_reader_view.dart';

class ScanView extends StatefulWidget {
  ScanView({Key key}) : super(key: key);

  @override
  _ScanViewState createState() => new _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  GlobalKey<QrcodeReaderViewState> _key = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: QrcodeReaderView(
        key: _key,
        onScan: onScan,
        headerWidget: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
    );
  }

  Future onScan(String data) async {
    Navigator.pop(context,data);
    // await showCupertinoDialog(
    //   context: context,
    //   builder: (context) {
    //     return CupertinoAlertDialog(
    //       title: Text("扫码结果"),
    //       content: Text(data),
    //       actions: <Widget>[
    //         CupertinoDialogAction(
    //           child: Text("确认"),
    //           onPressed: () =>Navigator.pop(context,data),
    //         )
    //       ],
    //     );
    //   },
    // );
    // _key.currentState.startScan();
  }

  @override
  void dispose() {
    super.dispose();
  }
}