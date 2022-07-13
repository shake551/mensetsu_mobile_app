import 'package:http/http.dart' as http;

class AuthRepository {
  Future<http.Response> auth(String username, String password) {
    final result = http.post(Uri.http('10.0.2.2:8000', 'token'),
        body: {'username': username, 'password': password});

    return result;
  }
}
