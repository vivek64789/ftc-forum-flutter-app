import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftc_forum/cubits/users/question/question_cubit.dart';
import 'package:ftc_forum/models/section.dart';
import 'package:ftc_forum/widgets/question_card.dart';

class SectionScreen extends StatefulWidget {
  final Section section;
  SectionScreen({Key? key, required this.section}) : super(key: key);
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
    final _questionCubit = BlocProvider.of<QuestionCubit>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.section.name.toString(),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QuestionCard(
                  downVotedBy: [],
                  upVotedBy: [],
                  uid: "",
                  qid: '1',
                  name: "John Doe",
                  profileUrl: "profileUrl",
                  date: DateTime.now(),
                  title: "title",
                  description: [],
                  onPress: () {},
                  imageUrl: "",
                ),
                QuestionCard(
                  downVotedBy: [],
                  upVotedBy: [],
                  uid: "",
                  qid: '2',
                  name: "John Doe",
                  profileUrl: "profileUrl",
                  date: DateTime.now(),
                  title: "title",
                  description: [],
                  onPress: () {},
                  imageUrl: "",
                ),
                QuestionCard(
                  downVotedBy: [],
                  upVotedBy: [],
                  uid: "",
                  qid: '3',
                  name: "John Doe",
                  profileUrl: "profileUrl",
                  date: DateTime.now(),
                  title: "title",
                  description: [],
                  onPress: () {},
                  imageUrl: "",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
