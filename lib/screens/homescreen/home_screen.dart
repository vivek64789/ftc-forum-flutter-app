import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftc_forum/blocs/app/app_bloc.dart';
import 'package:ftc_forum/cubits/users/question/question_cubit.dart';
import 'package:ftc_forum/models/question.dart';
import 'package:ftc_forum/models/user_model.dart';
import 'package:ftc_forum/repositories/user_repository.dart';
import 'package:ftc_forum/widgets/question_card.dart';

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
    final _appBloc = BlocProvider.of<AppBloc>(context);
    final _questionCubit = BlocProvider.of<QuestionCubit>(context);
    _questionCubit.uidChanged(_appBloc.state.user.id);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('FTC Forum Feed')),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Padding(
            padding: EdgeInsets.only(bottom: size.height * 0.2),
            child: Center(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _questionCubit.fetchQuestions(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final doc = snapshot.data!.docs[index];
                      // print(doc.data());

                      final question = Question.fromMap(doc.data(), doc.id);

                      // print(question);
                      final user =
                          _questionCubit.fetchUserById(question.uid.toString());
                      return FutureBuilder<User>(
                        future: user,
                        builder: (userContext, userSnapshot) {
                          if (userSnapshot.hasError) {
                            return Center(
                              child: Text('Error: ${userSnapshot.error}'),
                            );
                          }
                          if (!userSnapshot.hasData) {
                            return Center(
                              child: Container(
                                  margin: EdgeInsets.all(size.height * 0.1),
                                  child: const CircularProgressIndicator()),
                            );
                          }
                          return BlocBuilder<QuestionCubit, QuestionState>(
                            builder: (context, state) {
                              return QuestionCard(
                                section: question.sectionId.toString(),
                                category: question.categoryId.toString(),
                                qid: question.id,
                                uid: question.uid.toString(),
                                profileUrl: userSnapshot.data!.photo.toString(),
                                name: userSnapshot.data!.name.toString(),
                                date: question.date as DateTime,
                                title: question.title.toString(),
                                description:
                                    question.description as List<dynamic>,
                                upvotes: question.upVotes.toString(),
                                upVotedBy: question.upVotedBy,
                                downVotedBy: question.downVotedBy,
                                downvotes: question.downVotes.toString(),
                                comments: question.replyCount.toString(),
                                onPress: () {},
                                imageUrl: question.imageUrl.toString(),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
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
                builder: (context) => BlocProvider(
                  create: (_) => QuestionCubit(UserRepository()),
                  child: WriteQuestion(
                    categoryId: "",
                    sectionId: "",
                    qid: "",
                    uid: "",
                    size: size,
                  ),
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
