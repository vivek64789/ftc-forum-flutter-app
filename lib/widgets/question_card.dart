import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:ftc_forum/cubits/users/question/question_cubit.dart';
import 'package:ftc_forum/cubits/users/reply/reply_cubit.dart';
import 'package:ftc_forum/repositories/user_repository.dart';
import 'package:ftc_forum/widgets/replies_thread.dart';
import 'package:ftc_forum/widgets/vote_button.dart';

class QuestionCard extends StatefulWidget {
  final String qid;
  final String uid;
  final List<String>? upVotedBy;
  final List<String>? downVotedBy;
  final String profileUrl;
  final String imageUrl;
  final String name;
  final DateTime date;
  final String title;
  final List<dynamic> description;
  final String upvotes;
  final String downvotes;
  final String comments;
  final String category;
  final Function onPress;
  final Color bgColor, textColor;
  QuestionCard({
    Key? key,
    required this.name,
    required this.uid,
    required this.downVotedBy,
    required this.upVotedBy,
    required this.qid,
    required this.imageUrl,
    required this.profileUrl,
    required this.date,
    required this.title,
    required this.description,
    this.upvotes = "0",
    this.downvotes = "0",
    this.comments = "0",
    required this.onPress,
    this.category = "General",
    this.bgColor = Colors.white,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  bool isCommentActive = false;

  bool isUpvoted(List<String>? upvotedBy, String currentUserId) {
    return upvotedBy!.contains(currentUserId);
  }

  bool isDownvoted(List<String>? downvotedBy, String currentUserId) {
    return downvotedBy!.contains(currentUserId);
  }

  @override
  Widget build(BuildContext context) {
    final _questionCubit = BlocProvider.of<QuestionCubit>(context);

    final quill.QuillController _quillController = quill.QuillController(
        document: quill.Document.fromJson(widget.description),
        selection: const TextSelection.collapsed(offset: 0));
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.03, vertical: size.height * 0.01),
          padding: EdgeInsets.all(size.width * 0.03),
          // height: size.height * 0.2,
          decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: BorderRadius.circular(size.height * 0.01),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                    child: ClipOval(
                      child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1024px-Circle-icons-profile.svg.png'),
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        widget.date.year.toString() +
                            "-" +
                            widget.date.month.toString() +
                            "-" +
                            widget.date.day.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    quill.QuillEditor.basic(
                        controller: _quillController, readOnly: true),
                    Image(image: NetworkImage(widget.imageUrl)),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      VoteButton(
                        icon: Icons.thumb_up,
                        isSelected: isUpvoted(
                            widget.upVotedBy, _questionCubit.state.uid),
                        onPress: () {
                          isUpvoted(widget.upVotedBy, _questionCubit.state.uid)
                              ? _questionCubit.decreaseUpvoteQuestion(
                                  questionId: widget.qid,
                                  updatedVote:
                                      int.parse(widget.upvotes.toString()) - 1)
                              : _questionCubit.upvoteQuestion(
                                  questionId: widget.qid,
                                  updatedVote:
                                      int.parse(widget.upvotes.toString()) + 1,
                                );
                        },
                      ),
                      Text(
                        widget.upvotes,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      VoteButton(
                        icon: Icons.thumb_down,
                        isSelected: isDownvoted(
                            widget.downVotedBy, _questionCubit.state.uid),
                        onPress: () => {
                          isDownvoted(
                                  widget.downVotedBy, _questionCubit.state.uid)
                              ? _questionCubit.decreaseDownvoteQuestion(
                                  questionId: widget.qid,
                                  updatedVote: int.parse(widget.downvotes) + 1)
                              : _questionCubit.downvoteQuestion(
                                  questionId: widget.qid,
                                  updatedVote:
                                      int.parse(widget.downvotes.toString()) -
                                          1,
                                )
                        },
                      ),
                      Text(
                        widget.downvotes,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      VoteButton(
                        icon: Icons.comment,
                        isSelected: false,
                        onPress: () {
                          setState(() {
                            context.read<ReplyCubit>().qidChanged(widget.qid);
                            isCommentActive = !isCommentActive;
                          });
                        },
                      ),
                      Text(
                        widget.comments,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Text(
                    "Web Development",
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              // Only show when comment is active
              isCommentActive
                  ? BlocProvider(
                      create: (_) => ReplyCubit(UserRepository()),
                      child: RepliesThread(size: size, qid: widget.qid),
                    )
                  : Container()
            ],
          ),
        ),
      ],
    );
  }
}
