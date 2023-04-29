// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom(
      {Key? key,
      required this.hintText,
      this.isPass = false,
      required this.textInputType,
      required this.controller})
      : super(key: key);
  final String hintText;
  final bool isPass;
  final TextInputType textInputType;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: inputBorder,
          focusedBorder: inputBorder,
          border: inputBorder,
          disabledBorder: inputBorder,
          filled: true,
          contentPadding: EdgeInsets.all(4)),
      obscureText: isPass,
      keyboardType: textInputType,
    );
  }
}
