import 'package:flutter/material.dart';

class TestQuestionMultiplechoice extends StatefulWidget {
  final String question;
  final String answers;
  final String correctoption;
  const TestQuestionMultiplechoice({
    super.key,
    required this.question,
    required this.answers,
    required this.correctoption,
  });

  @override
  State<TestQuestionMultiplechoice> createState() =>
      _TestQuestionMultiplechoiceState();
}

class _TestQuestionMultiplechoiceState
    extends State<TestQuestionMultiplechoice> {
  @override
  Widget build(BuildContext context) {
    var answers = widget.answers.split(",");
    return Card.outlined(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.question),
            SizedBox(
              height: 100,
              width: 1000,
              child: ListView.builder(
                itemCount: answers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(child: Text(answers[index]));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestChip extends StatefulWidget {
  const TestChip({super.key});

  @override
  State<TestChip> createState() => _TestChipState();
}

class _TestChipState extends State<TestChip> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class TestQuestionboolean extends StatefulWidget {
  const TestQuestionboolean({super.key});

  @override
  State<TestQuestionboolean> createState() => _TestQuestionbooleanState();
}

class _TestQuestionbooleanState extends State<TestQuestionboolean> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
