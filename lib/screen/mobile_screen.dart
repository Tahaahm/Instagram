// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/global_veriable.dart';

class MobileSceen extends StatefulWidget {
  MobileSceen({Key? key}) : super(key: key);

  @override
  State<MobileSceen> createState() => _MobileSceenState();
}

class _MobileSceenState extends State<MobileSceen> {
  int _page = 0;

  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void navTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChange,
          children: homeScreen,
        ),
        bottomNavigationBar: CupertinoTabBar(
          currentIndex: _page,
          onTap: navTapped,
          backgroundColor: mobileBackgroundColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                  color: _page == 0 ? primaryColor : secondaryColor,
                  Icons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  color: _page == 1 ? primaryColor : secondaryColor,
                  Icons.search),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  color: _page == 2 ? primaryColor : secondaryColor,
                  Icons.add_circle_outline),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  color: _page == 3 ? primaryColor : secondaryColor,
                  Icons.favorite),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                color: _page == 4 ? primaryColor : secondaryColor,
                Icons.person,
              ),
            ),
          ],
        ));
  }
}
