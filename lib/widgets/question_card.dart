import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:ftc_forum/cubits/users/profile/profile_cubit.dart';
import 'package:ftc_forum/cubits/users/question/question_cubit.dart';
import 'package:ftc_forum/cubits/users/reply/reply_cubit.dart';
import 'package:ftc_forum/repositories/user_repository.dart';
import 'package:ftc_forum/screens/user_profile/user_profile_screen.dart';
import 'package:ftc_forum/widgets/replies_thread.dart';
import 'package:ftc_forum/widgets/vote_button.dart';
import 'package:ftc_forum/widgets/write_comment.dart';
import 'package:ftc_forum/widgets/write_question.dart';

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
  final String section;
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
    required this.section,
    this.upvotes = "0",
    this.downvotes = "0",
    this.comments = "0",
    required this.onPress,
    required this.category,
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

  bool isUserQuestion(String questionUserId, String currentUserId) {
    return questionUserId == currentUserId;
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => ProfileCubit(UserRepository()),
                            child: BlocProvider(
                              create: (context) =>
                                  QuestionCubit(UserRepository()),
                              child: UserProfileScreen(
                                questionUserId: widget.uid,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(widget
                                    .profileUrl.isEmpty
                                ? "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1024px-Circle-icons-profile.svg.png"
                                : widget.profileUrl),
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
                        ),
                      ],
                    ),
                  ),
                  // delete button
                  isUserQuestion(widget.uid, _questionCubit.state.uid)
                      ? Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // alert
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) =>
                                          QuestionCubit(UserRepository()),
                                      child: WriteQuestion(
                                        categoryId: widget.category,
                                        sectionId: widget.section,
                                        qid: widget.qid,
                                        uid: widget.uid,
                                        description: widget.description,
                                        imageUrl: widget.imageUrl,
                                        title: widget.title,
                                        size: size,
                                        isInit: true,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.green,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // alert
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Delete Question"),
                                      content: const Text(
                                          "Are you sure you want to delete this question?"),
                                      actions: [
                                        TextButton(
                                          child: const Text("Cancel"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text("Delete"),
                                          onPressed: () {
                                            _questionCubit.deleteQuestion(
                                                context,
                                                questionId: widget.qid);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        )
                      : Container(),
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
                    widget.imageUrl.isNotEmpty
                        ? Image(image: NetworkImage(widget.imageUrl))
                        : Container(),
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
                      BlocBuilder<QuestionCubit, QuestionState>(
                        builder: (context, state) {
                          return state.upvoteStatus == UpvoteStatus.loading
                              ? Container(
                                  margin: EdgeInsets.only(
                                    bottom: size.width * 0.041,
                                    left: size.width * 0.041,
                                    right: size.width * 0.062,
                                  ),
                                  width: size.width * 0.02,
                                  height: size.width * 0.02,
                                  child: Icon(Icons.thumb_up,
                                      size: size.width * 0.04))
                              : VoteButton(
                                  icon: Icons.thumb_up,
                                  isSelected: isUpvoted(widget.upVotedBy,
                                      _questionCubit.state.uid),
                                  onPress: () {
                                    if (int.parse(widget.upvotes) == 0 ||
                                        int.parse(widget.upvotes) > 0) {
                                      isUpvoted(widget.upVotedBy,
                                              _questionCubit.state.uid)
                                          ? _questionCubit
                                              .decreaseUpvoteQuestion(
                                                  questionId: widget.qid,
                                                  updatedVote: int.parse(widget
                                                          .upvotes
                                                          .toString()) -
                                                      1)
                                          : _questionCubit.upvoteQuestion(
                                              questionId: widget.qid,
                                              updatedVote: int.parse(widget
                                                      .upvotes
                                                      .toString()) +
                                                  1,
                                            );
                                    }
                                  },
                                );
                        },
                      ),
                      Text(
                        widget.upvotes,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      BlocBuilder<QuestionCubit, QuestionState>(
                        builder: (context, state) {
                          return state.downvoteStatus == DownvoteStatus.loading
                              ? Container(
                                  margin: EdgeInsets.only(
                                    top: size.width * 0.01,
                                    left: size.width * 0.041,
                                    right: size.width * 0.062,
                                  ),
                                  width: size.width * 0.02,
                                  height: size.width * 0.02,
                                  child: Icon(Icons.thumb_down,
                                      size: size.width * 0.04))
                              : VoteButton(
                                  icon: Icons.thumb_down,
                                  isSelected: isDownvoted(widget.downVotedBy,
                                      _questionCubit.state.uid),
                                  onPress: () => {
                                    if (int.parse(widget.upvotes) == 0 ||
                                        int.parse(widget.upvotes) > 0)
                                      {
                                        isDownvoted(widget.downVotedBy,
                                                _questionCubit.state.uid)
                                            ? _questionCubit
                                                .decreaseDownvoteQuestion(
                                                    questionId: widget.qid,
                                                    updatedVote: int.parse(
                                                            widget.downvotes) -
                                                        1)
                                            : _questionCubit.downvoteQuestion(
                                                questionId: widget.qid,
                                                updatedVote: int.parse(widget
                                                        .downvotes
                                                        .toString()) +
                                                    1,
                                              )
                                      }
                                  },
                                );
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
