import 'package:flutter/material.dart';
import 'package:mensetsu_mobile_app/api/auth.dart';
import 'package:mensetsu_mobile_app/interview/home.dart';
import 'package:mensetsu_mobile_app/user/login_model.dart';
import 'package:provider/provider.dart';

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

                          if (response.statusCode == 200) {
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
