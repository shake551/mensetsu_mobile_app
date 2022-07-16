import 'package:flutter/material.dart';
import 'package:mensetsu_mobile_app/api/interview.dart';

class PostInterview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('質問投稿'),
          backgroundColor: Colors.orange,
        ),
        backgroundColor: Colors.orangeAccent,
        body: Center(
          child: PostInterviewForm(),
        ),
    );
  }
}

class PostInterviewForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PostInterviewForm();
}

class _PostInterviewForm extends State<PostInterviewForm> {
  String _content = '';

  String? emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '入力してください';
    }
    return null;
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(50.0),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '質問内容',
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () async {
                var response = await InterviewRepository().postInterview(
                  _content,
                );

                if (response.statusCode == 200) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostInterview(),
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('投稿しました'),
                    ),
                  );
                }
              },
              child: const Text('投稿'),
            ),
          ),
        ),
      ],
    );
  }
}
