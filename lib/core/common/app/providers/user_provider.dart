import 'package:flutter/material.dart';
import 'package:sstation/features/profile/domain/entities/user.dart';

class UserProvider extends ChangeNotifier {
  LocalUser? _user;

  LocalUser? get user => _user;

  void initUser(LocalUser? user) {
    _user = user;
    Future.delayed(Duration.zero, notifyListeners);
  }

  set user(LocalUser? user) {
    _user = user;
    Future.delayed(Duration.zero, notifyListeners);
  }
}
