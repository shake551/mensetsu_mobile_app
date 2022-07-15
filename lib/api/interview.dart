import 'dart:convert';

import 'package:http/http.dart' as http;

class InterviewRepository {
  Future<http.Response> obtainRandomInterview() {
    final result = http.get(Uri.http('10.0.2.2:8000', 'interview/random'));

    return result;
  }

  Future<http.Response> bookmarkInterview(int interviewId) {
    final body = jsonEncode({
      'interview_id': interviewId,
    });

    final result = http.post(
      Uri.http('10.0.2.2:8000', 'interview/bookmark'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    return result;
  }
}
