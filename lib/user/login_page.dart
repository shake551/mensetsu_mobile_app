import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mensetsu_mobile_app/api/auth.dart';
import 'package:mensetsu_mobile_app/interview/home.dart';
import 'package:mensetsu_mobile_app/user/login_model.dart';
import 'package:mensetsu_mobile_app/user/token_model.dart';
import 'package:provider/provider.dart';

const storage = FlutterSecureStorage();

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginModel(
        AuthRepository(),
      ),
      child: LoginApp(),
    );
  }
}

class LoginApp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン'),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.orangeAccent,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'UserName',
                    hintText: 'ユーザ名を入力してください',
                  ),
                  validator: context.read<LoginModel>().emptyValidator,
                  onSaved: (value) =>
                      context.read<LoginModel>().username = value!,
                ),
                TextFormField(
                  obscureText: !context.watch<LoginModel>().showPassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'パスワードを入力してください',
                    suffixIcon: IconButton(
                      icon: Icon(context.watch<LoginModel>().showPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () =>
                          context.read<LoginModel>().togglePasswordVisible(),
                    ),
                  ),
                  validator: context.read<LoginModel>().emptyValidator,
                  onSaved: (value) =>
                      context.read<LoginModel>().password = value!,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                  child: Text(
                    context.watch<LoginModel>().message,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                      onPressed: () async {
                        context.read<LoginModel>().setMessage('');

                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          var response = await context.read<LoginModel>().auth(
                                context.read<LoginModel>().username,
                                context.read<LoginModel>().password,
                              );

                          var jsonResponse = TokenModel.fromJson(
                              json.decode(utf8.decode(response.bodyBytes)));

                          if (response.statusCode == 200) {

                            await storage.write(key: 'access_token', value: jsonResponse.access_token);

                            final String? access_token = await storage.read(key: 'access_token');

                            print(access_token);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InterviewHome(),
                              ),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('ログインしました'),
                              ),
                            );
                          } else {
                            context
                                .read<LoginModel>()
                                .setMessage('ユーザー名またはパスワードが誤っています');
                          }
                        }
                      },
                      child: const Text('ログイン'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
