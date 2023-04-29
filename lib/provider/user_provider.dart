// ignore_for_file: unused_field, unused_local_variable

import 'package:instagram/model/user.dart';
import 'package:flutter/material.dart';
import 'package:instagram/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  final AuthMethod _authMethod = AuthMethod();

  User? _user;

  User get getUser => _user!;

  Future<void> getReferesh() async {
    User user = await _authMethod.getUserDetial();
    _user = user;
    notifyListeners();
  }
}
