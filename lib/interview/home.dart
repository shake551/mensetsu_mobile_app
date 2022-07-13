import 'package:flutter/material.dart';

class InterviewHome extends StatelessWidget {
  Card generateCard(String title, String subtitle, Icon icon) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        margin: const EdgeInsets.all(10.0),
        width: 300,
        height: 150,
        child: ListTile(
          leading: Container(
            margin: const EdgeInsets.only(top: 30),
            child: icon,
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
          subtitle: Container(
            margin: const EdgeInsets.all(10),
            child: Text(
              subtitle,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('めんせ通'),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.orangeAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: generateCard(
              'ランダムで出題',
              '登録された質問がランダムで出題されます．本番さながらの面接対策ができます．',
              const Icon(
                Icons.shuffle,
                size: 50,
              ),
            ),
          ),
          Center(
            child: generateCard(
              'マークした問題',
              '過去に自分がマークした質問一覧を見ることができます．面接直前などに確認して面接に向かうことができます．',
              const Icon(
                Icons.heart_broken,
                size: 50,
              ),
            ),
          ),
          Center(
            child: generateCard(
              '質問を登録する',
              '実際に面接を受けた際にされた質問を投稿できます．匿名投稿ですので今後面接を受ける人のために投稿してみてください．',
              const Icon(
                Icons.create,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
