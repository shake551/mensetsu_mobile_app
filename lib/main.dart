import 'package:flutter/material.dart';
import 'package:mensetsu_mobile_app/user/login_page.dart';
import 'package:mensetsu_mobile_app/user/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'めんせ通',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                child: const Text(
                  'めんせ通',
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                child: Image.asset(
                  'images/icon.png',
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: SignupButton(),
            ),
            Center(
              child: LoginButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        height: 70,
        child: ElevatedButton(
          child: Text("Signup"),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            onPrimary: Colors.black,
            shape: const StadiumBorder(),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupPage()),
            );
          },
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        height: 70,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
            onPrimary: Colors.black,
            shape: const StadiumBorder(),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: const Text("Login"),
        ),
      ),
    );
  }
}
