import 'package:flutter/material.dart';

class RandomInterview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ランダム出題'),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.orangeAccent,
      body: Center(
        child: SizedBox(
          height: 600,
          child: PageView(
            controller: PageController(viewportFraction: 0.7),
            children: const [
              InterviewCard(
                text: 'これまで開発してきたもので一番自信があるものはなんですか',
                color: Colors.blue,
              ),
              InterviewCard(
                text: '使用した技術を選んだ理由はなんですか',
                color: Colors.green,
              ),
              InterviewCard(
                text: 'こだわったポイントはどこですか',
                color: Colors.yellow,
              ),
              InterviewCard(
                text: '一番難しかったことはなんですか',
                color: Colors.pink,
              ),
              InterviewCard(
                text: '今後改善したいところはありますか',
                color: Colors.deepPurpleAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InterviewCard extends StatefulWidget {
  final String text;
  final Color color;

  const InterviewCard({
    required this.text,
    required this.color,
  });

  @override
  State<InterviewCard> createState() => _InterviewCardState();
}

class _InterviewCardState extends State<InterviewCard> with AutomaticKeepAliveClientMixin<InterviewCard> {
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
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
