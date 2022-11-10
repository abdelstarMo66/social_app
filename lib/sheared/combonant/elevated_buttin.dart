import 'package:flutter/material.dart';

Widget button({
  double? radius,
  Color? backGround,
  required VoidCallback? onpressed,
  required Widget? widget,
}) =>
    ElevatedButton(
      onPressed: onpressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(backGround!),
      ),
      child: widget,
    );
