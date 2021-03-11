import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Toasts {
  static toast(BuildContext context, String msg,
      {duration = const Duration(milliseconds: 2500),SnackBarAction action}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: duration,
      action: action,
      backgroundColor: Colors.redAccent,
    ));
  }
}
