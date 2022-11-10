import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void ShowToast({
  required String msg,
  required Color? color,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    fontSize: 16.0,
  );
}
