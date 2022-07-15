import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mensetsu_mobile_app/api/interview.dart';
import 'package:mensetsu_mobile_app/interview/home.dart';
import 'package:mensetsu_mobile_app/interview/model.dart';

class RandomInterview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ランダム出題'),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.orangeAccent,
      body: InterviewCardList(),
    );
  }
}

class InterviewCard extends StatefulWidget {
  final String text;
  final Color color;
  final bool isLast;

  const InterviewCard({
    required this.text,
    required this.color,
    required this.isLast,
  });

  @override
  State<InterviewCard> createState() => _InterviewCardState();
}

class _InterviewCardState extends State<InterviewCard>
    with AutomaticKeepAliveClientMixin<InterviewCard> {
  bool _isBookmarked = false;

  void _toggleBookmark() {
    setState(() {
      if (_isBookmarked) {
        _isBookmarked = false;
      } else {
        _isBookmarked = true;
      }
    });
  }

  Widget _finishButton(bool isLast) {
    if (isLast) {
      return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InterviewHome(),
            ),
          );
        },
        child: const Text('終了'),
      );
    } else {
      return ElevatedButton(
        child: null,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: Colors.transparent,
        ),
        onPressed: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 300,
            child: Card(
              color: widget.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: IconButton(
              iconSize: 80,
              icon: (_isBookmarked
                  ? const Icon(
                      Icons.bookmark,
                    )
                  : const Icon(
                      Icons.bookmark_border,
                    )),
              // color: Colors.red[500],
              onPressed: _toggleBookmark,
            ),
          ),
          Center(
            child: _finishButton(widget.isLast),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class InterviewCardList extends StatefulWidget {
  var colors = [
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.pink,
    Colors.deepPurpleAccent
  ];

  @override
  State<InterviewCardList> createState() => _InterviewCardListState();
}

class _InterviewCardListState extends State<InterviewCardList> {
  List interviewData = [];

  Future<void> getData() async {
    var response = await InterviewRepository().obtainRandomInterview();

    List jsonResponse = json
        .decode(utf8.decode(response.bodyBytes))
        .map((i) => InterviewModel.fromJson(i))
        .toList();

    setState(() {
      interviewData = jsonResponse;
    });
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    print(interviewData);
    return Center(
      child: SizedBox(
        height: 600,
        child: PageView(
          controller: PageController(viewportFraction: 0.7),
          children: [
            for (int i = 0; i < interviewData.length; i++) ...{
              InterviewCard(
                text: interviewData[i].content,
                color: widget.colors[i],
                isLast: i == interviewData.length - 1,
              ),
            },
          ],
        ),
      ),
    );
  }
}
