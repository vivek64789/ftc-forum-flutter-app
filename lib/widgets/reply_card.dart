import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:ftc_forum/constants.dart';
import 'package:ftc_forum/cubits/users/profile/profile_cubit.dart';
import 'package:ftc_forum/cubits/users/question/question_cubit.dart';
import 'package:ftc_forum/cubits/users/reply/reply_cubit.dart';
import 'package:ftc_forum/models/user_model.dart';
import 'package:ftc_forum/repositories/user_repository.dart';
import 'package:ftc_forum/screens/user_profile/user_profile_screen.dart';
import 'package:ftc_forum/widgets/handle_bar.dart';
import 'package:ftc_forum/widgets/rounded_button.dart';
import 'package:ftc_forum/widgets/vote_button.dart';
import 'package:ftc_forum/widgets/write_comment.dart';

class ReplyCard extends StatelessWidget {
  final String id;
  final String uid;
  final Future<User> user;
  final List<String>? upvotedBy;
  final List<String>? downvotedBy;
  final String name;
  final String profileUrl;
  final DateTime date;
  final List<dynamic>? reply;
  final String upvotes;
  final String downvotes;
  final Function onPress;
  final Color bgColor, textColor;
  final String? qid;
  ReplyCard({
    Key? key,
    required this.id,
    required this.upvotedBy,
    required this.downvotedBy,
    required this.user,
    required this.uid,
    required this.name,
    required this.profileUrl,
    required this.date,
    required this.reply,
    this.qid,
    this.upvotes = "0",
    this.downvotes = "0",
    required this.onPress,
    this.bgColor = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  quill.QuillController _controller = quill.QuillController.basic();

  bool isUpvoted(List<String>? upvotedBy, String currentUserId) {
    return upvotedBy!.contains(currentUserId);
  }

  bool isDownvoted(List<String>? downvotedBy, String currentUserId) {
    return downvotedBy!.contains(currentUserId);
  }

  bool isUserReply(String questionUserId, String currentUserId) {
    return questionUserId == currentUserId;
  }

  @override
  Widget build(BuildContext context) {
    final _replyCubit = BlocProvider.of<ReplyCubit>(context);
    final _questionCubit = BlocProvider.of<QuestionCubit>(context);

    final quill.QuillController _quillController = quill.QuillController(
        document: quill.Document.fromJson(reply as List<dynamic>),
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
            color: bgColor,
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
                                questionUserId: uid,
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
                            backgroundImage: NetworkImage(profileUrl.isEmpty
                                ? "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1024px-Circle-icons-profile.svg.png"
                                : profileUrl),
                          ),
                        ),
                        SizedBox(width: size.width * 0.03),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              date.year.toString() +
                                  "-" +
                                  date.month.toString() +
                                  "-" +
                                  date.day.toString(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // delete button
                  isUserReply(uid, _questionCubit.state.uid)
                      ? Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _controller = quill.QuillController(
                                  document: quill.Document.fromJson(
                                      reply as List<dynamic>),
                                  selection:
                                      const TextSelection.collapsed(offset: 0),
                                );
                                showBottomSheet(
                                  context: context,
                                  builder: (_) => Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.height * 0.02),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        // create handle bar
                                        HandleBar(size: size),

                                        // create quill editor
                                        quill.QuillToolbar.basic(
                                            controller: _controller),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              top: size.height * 0.02,
                                            ),
                                            child: quill.QuillEditor.basic(
                                              controller: _controller,
                                              readOnly:
                                                  false, // true for view only mode
                                            ),
                                          ),
                                        ),
                                        RoundedButton(
                                          text: "Update",
                                          press: () {
                                            var json = jsonEncode(_controller
                                                .document
                                                .toDelta()
                                                .toJson());
                                            context
                                                .read<ReplyCubit>()
                                                .descriptionChanged(json);
                                            context
                                                .read<ReplyCubit>()
                                                .updatePostReply(context, id);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                // alert
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
                                            _replyCubit.deleteComment(
                                                context, id, qid.toString());
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
                    quill.QuillEditor.basic(
                        controller: _quillController, readOnly: true),
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
                      BlocBuilder<ReplyCubit, ReplyState>(
                        builder: (context, state) {
                          return state.upvoteStatus == ReplyUpvoteStatus.loading
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
                                  isSelected: isUpvoted(
                                      upvotedBy, _replyCubit.state.uid),
                                  onPress: () {
                                    if (int.parse(upvotes) == 0 ||
                                        int.parse(upvotes) > 0) {
                                      isUpvoted(
                                              upvotedBy, _replyCubit.state.uid)
                                          ? context
                                              .read<ReplyCubit>()
                                              .decreaseUpvoteReply(
                                                  replyId: id,
                                                  updatedVote:
                                                      int.parse(upvotes) - 1)
                                          : context
                                              .read<ReplyCubit>()
                                              .upvoteReply(
                                                  replyId: id,
                                                  updatedVote:
                                                      int.parse(upvotes) + 1);
                                    }
                                  },
                                );
                        },
                      ),
                      Text(
                        upvotes,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      BlocBuilder<ReplyCubit, ReplyState>(
                        builder: (context, state) {
                          return state.downvoteStatus ==
                                  ReplyDownvoteStatus.loading
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
                                  isSelected: isDownvoted(
                                      downvotedBy, _replyCubit.state.uid),
                                  onPress: () {
                                    if (int.parse(upvotes) == 0 ||
                                        int.parse(upvotes) > 0) {
                                      isDownvoted(
                                        downvotedBy,
                                        _replyCubit.state.uid,
                                      )
                                          ? context
                                              .read<ReplyCubit>()
                                              .decreaseDownvoteReply(
                                                  replyId: id,
                                                  updatedVote:
                                                      int.parse(downvotes) - 1)
                                          : context
                                              .read<ReplyCubit>()
                                              .downvoteReply(
                                                  replyId: id,
                                                  updatedVote:
                                                      int.parse(downvotes) + 1);
                                    }
                                  },
                                );
                        },
                      ),
                      Text(
                        downvotes,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
