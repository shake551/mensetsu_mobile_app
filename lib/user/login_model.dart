import 'package:flutter/material.dart';
import 'package:http/src/response.dart';
import 'package:mensetsu_mobile_app/api/auth.dart';

class LoginModel extends ChangeNotifier {
  final AuthRepository repository;
  String username = '';
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

  Future<Response> auth(String username, String password) async {
    var results = await repository.auth(username, password);
    return results;
  }
}
