// ignore_for_file: prefer_const_constructors

import 'package:flutter/widgets.dart';
import 'package:instagram/screen/feed_screen.dart';
import 'package:instagram/screen/post_screen.dart';

const webScreenSize = 600;

var homeScreen = [
  FeedScreen(),
  Center(
    child: Text("Search"),
  ),
  PostScreen(),
  Center(
    child: Text("Favorite"),
  ),
  Center(
    child: Text("Person"),
  ),
];
