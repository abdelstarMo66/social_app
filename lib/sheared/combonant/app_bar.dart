import 'package:flutter/material.dart';
import 'package:social_app/sheared/style/icon/icon_broken.dart';

AppBar defAppBar({
  @required context,
  Widget? title,
  List<Widget>? actions,
  bool center = false,
}) =>
    AppBar(
      title: title,
      actions: actions,
      centerTitle: center,
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      },icon: Icon(IconBroken.Arrow___Left_2),),
    );
