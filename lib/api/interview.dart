import 'package:http/http.dart' as http;

class InterviewRepository {
  Future<http.Response> obtainRandomInterview() {
    final result = http.get(Uri.http('10.0.2.2:8000', 'interview/random'));

    return result;
  }
}
