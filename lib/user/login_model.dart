import 'package:flutter/material.dart';
import 'package:mensetsu_mobile_app/api/auth.dart';

class LoginModel extends ChangeNotifier {
  final AuthRepository repository;
  String id = '';
  String password = '';
  String message = '';
  bool showPassword = false;

  LoginModel(this.repository);

  void setMessage(String value) {
    message = value;
    notifyListeners();
  }

  void togglePasswordVisible() {
    showPassword = !showPassword;
    notifyListeners();
  }

  String? emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '入力してください';
    }
    return null;
  }

  Future<bool> auth() async {
    var results = await repository.auth();
    return results;
  }
}
