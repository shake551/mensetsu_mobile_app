import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mensetsu_mobile_app/user/login_page.dart';

class InterviewRepository {
  Future<http.Response> obtainRandomInterview() async {
    final accessToken = await storage.read(key: 'access_token');

    final result = await http.get(Uri.http('10.0.2.2:8000', 'interview/random'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      }
    );

    return result;
  }

  Future<http.Response> bookmarkInterview(int interviewId) async {
    final body = jsonEncode({
      'interview_id': interviewId,
    });

    final accessToken = await storage.read(key: 'access_token');

    final result = await http.post(
      Uri.http('10.0.2.2:8000', 'interview/bookmark'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: body,
    );

    return result;
  }

  Future<http.Response> deleteBookmarkInterview(int interviewId) async {
    final body = jsonEncode({
      'interview_id': interviewId,
    });

    final accessToken = await storage.read(key: 'access_token');

    final result = await http.delete(
      Uri.http('10.0.2.2:8000', 'interview/bookmark'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: body,
    );

    return result;
  }

  Future<http.Response> obtainMarkedInterview() async {
    final accessToken = await storage.read(key: 'access_token');

    final result = await http.get(Uri.http('10.0.2.2:8000', 'interview/bookmark'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      }
    );

    return result;
  }

  Future<http.Response> postInterview(String content) async {
    final body = jsonEncode({
      'content': content,
    });

    final accessToken = await storage.read(key: 'access_token');

    final result = await http.post(
      Uri.http('10.0.2.2:8000', 'interview'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: body,
    );

    return result;
  }
}
