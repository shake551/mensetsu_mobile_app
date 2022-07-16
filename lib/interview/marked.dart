import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mensetsu_mobile_app/api/interview.dart';
import 'package:mensetsu_mobile_app/interview/model.dart';

class MarkedInterview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('マークした問題'),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.orangeAccent,
      body: MarkedCardList(),
    );
  }
}

class MarkedCard extends StatefulWidget {
  final String content;
  final Color color;

  const MarkedCard({
    required this.content,
    required this.color,
  });

  @override
  State<StatefulWidget> createState() => _MarkedCardState();
}

class _MarkedCardState extends State<MarkedCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        color: widget.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
              child: Text(
                widget.content,
                textAlign: TextAlign.center,
              ),
            ),
        ),
    );
  }
}

class MarkedCardList extends StatefulWidget {
  var colors = [
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.pink,
    Colors.deepPurpleAccent
  ];

  @override
  State<StatefulWidget> createState() => _MarkedCardListState();
}

class _MarkedCardListState extends State<MarkedCardList> {
  List _markedInterviewList = [];

  Future<void> obtainMarkedInterviews() async {
    var response = await InterviewRepository().obtainMarkedInterview();

    List jsonResponse = json
        .decode(utf8.decode(response.bodyBytes))
        .map((i) => InterviewModel.fromJson(i))
        .toList();

    setState(() {
      _markedInterviewList = jsonResponse;
    });
  }

  @override
  void initState() {
    super.initState();

    obtainMarkedInterviews();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (int i = 0; i < _markedInterviewList.length; i++) ...{
          MarkedCard(
            content: _markedInterviewList[i].content,
            color: widget.colors[i % 5],
          ),
        }
      ],
    );
  }
}
