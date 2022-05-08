import 'package:flutter/material.dart';
import 'package:ftc_forum/widgets/question_card.dart';
import 'package:ftc_forum/widgets/replies_thread.dart';
import 'package:ftc_forum/widgets/reply_card.dart';
import 'package:ftc_forum/widgets/vote_button.dart';
import 'package:ftc_forum/widgets/write_question.dart';

class SectionScreen extends StatefulWidget {
  SectionScreen({Key? key}) : super(key: key);
  static Page page() => MaterialPage<void>(child: SectionScreen());
  static const String routeName = '/section';

  @override
  State<SectionScreen> createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
  bool isCommentActive = false;
  bool isUpvoteActive = false;
  bool isDownvoteActive = false;
  int currentNavigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Section Screen')),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QuestionCard(
                  profileUrl: "profileUrl",
                  date: "date",
                  title: "title",
                  description: "description",
                  onPress: () {},
                ),
                QuestionCard(
                  profileUrl: "profileUrl",
                  date: "date",
                  title: "title",
                  description: "description",
                  onPress: () {},
                ),
                QuestionCard(
                  profileUrl: "profileUrl",
                  date: "date",
                  title: "title",
                  description: "description",
                  onPress: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}