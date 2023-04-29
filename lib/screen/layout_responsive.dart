// ignore_for_file: prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:instagram/provider/user_provider.dart';
import 'package:instagram/utils/global_veriable.dart';
import 'package:provider/provider.dart';

class LayoutResponsive extends StatefulWidget {
  LayoutResponsive(
      {Key? key, required this.mobileScreen, required this.webScreen})
      : super(key: key);
  final Widget mobileScreen;
  final Widget webScreen;
  @override
  State<LayoutResponsive> createState() => _LayoutResponsiveState();
}

class _LayoutResponsiveState extends State<LayoutResponsive> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  void addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);

    await _userProvider.getReferesh();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        if (constraint.maxWidth > webScreenSize) {
          return widget.webScreen;
        } else {
          return widget.mobileScreen;
        }
      },
    );
  }
}
