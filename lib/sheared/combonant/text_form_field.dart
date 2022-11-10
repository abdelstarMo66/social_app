import 'package:flutter/material.dart';

import '../style/color/colors.dart';

Widget TextForm({
  required String? hint,
  String? lable,
  required TextEditingController? controller,
  required TextInputType? inputType,
  bool hidePass = false,
  required FormFieldValidator<String>? validator,
  required ValueChanged<String>? submitted,
  IconButton? suffix,
  Icon? prefix,
}) =>
    TextFormField(
      decoration: InputDecoration(
        labelText: lable,
        hintText: hint,
        prefixIcon: prefix,
        suffixIcon: suffix,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Gray, width: 1.0),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Gray, width: 1.0),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      style: TextStyle(
        color: Black,
      ),
      controller: controller,
      keyboardType: inputType,
      obscureText: hidePass,
      validator: validator,
      onFieldSubmitted: submitted,
    );
