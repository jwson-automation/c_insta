import 'package:c_insta/resouces/auth_methods.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetatils();
    _user = user;

    notifyListeners();
  }
}
