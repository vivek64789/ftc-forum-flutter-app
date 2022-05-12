import 'package:flutter/material.dart';
import 'package:ftc_forum/widgets/question_card.dart';
import 'package:ftc_forum/widgets/replies_thread.dart';
import 'package:ftc_forum/widgets/reply_card.dart';
import 'package:ftc_forum/widgets/vote_button.dart';
import 'package:ftc_forum/widgets/write_question.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static Page page() => MaterialPage<void>(child: HomeScreen());

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isCommentActive = false;
  bool isUpvoteActive = false;
  bool isDownvoteActive = false;
  int currentNavigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('FTC Forum Feed')),
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
      floatingActionButton: Container(
        width: size.width * 0.3,
        padding: EdgeInsets.all(size.height * 0.005),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(size.height * 0.01),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WriteQuestion(
                  size: size,
                ),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.background,
                size: size.height * 0.03,
              ),
              Text(
                "Ask a question",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.background),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
