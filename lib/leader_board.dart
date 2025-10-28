import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:it_quize/main.dart';
import 'package:it_quize/studentboxhive.dart';
import 'package:it_quize/theme.dart';

@Preview()
Widget preview() {
  return const LeaderBoard();
}

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  final Map<String, int> scoreandkey = {};

  @override
  void initState() {
    final box = Studentboxhive().passwordsbox;
    for (var key in box.keys) {
      if (key == teachername) {
        continue;
      }
      scoreandkey.addEntries({MapEntry(key, box.get(key)[3])});
    }
    final sortedEntries = scoreandkey.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    scoreandkey
      ..clear()
      ..addEntries(sortedEntries);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: MyTheme().appBar("LeaderBoard"),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.2,
            fit: BoxFit.cover,
            image: AssetImage("assets/images/leaderboard.png"),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: scoreandkey.length,
                itemBuilder: (context, index) {
                  final studentName = Studentboxhive().passwordsbox.get(
                    scoreandkey.keys.elementAt(index),
                  )[0];
                  Widget badge = SizedBox();
                  if (index == 0) {
                    badge = Icon(
                      Icons.emoji_events,
                      color: Colors.amber,
                      size: 45,
                    );
                  } else if (index == 1) {
                    badge = Icon(
                      Icons.emoji_events,
                      color: Colors.blueGrey,
                      size: 45,
                    );
                  } else if (index == 2) {
                    badge = Icon(
                      Icons.emoji_events,
                      color: Colors.brown,
                      size: 45,
                    );
                  } else if (index < 5) {
                    badge = Icon(
                      Icons.star,
                      color: Colors.blueAccent,
                      size: 45,
                    );
                  } else {
                    badge = SizedBox();
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            badge,
                            SizedBox(
                              width: 100,
                              child: Text(
                                "Ranks: ${index + 1}",
                                style: MyTheme().textfieldtextstyle.copyWith(
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Text(
                                "Name: $studentName",
                                style: MyTheme().textfieldtextstyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                "Score: ${scoreandkey.values.elementAt(index)}",
                                style: MyTheme().textfieldtextstyle.copyWith(
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                "Class: ${Studentboxhive().passwordsbox.get(scoreandkey.keys.elementAt(index))[2]}",
                                style: MyTheme().textfieldtextstyle.copyWith(
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
