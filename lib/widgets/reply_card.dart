import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:ftc_forum/constants.dart';
import 'package:ftc_forum/cubits/users/reply/reply_cubit.dart';
import 'package:ftc_forum/models/user_model.dart';
import 'package:ftc_forum/widgets/avatar_image.dart';
import 'package:ftc_forum/widgets/vote_button.dart';

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
    this.upvotes = "0",
    this.downvotes = "0",
    required this.onPress,
    this.bgColor = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  bool isUpvoted(List<String>? upvotedBy, String currentUserId) {
    return upvotedBy!.contains(currentUserId);
  }

  bool isDownvoted(List<String>? downvotedBy, String currentUserId) {
    return downvotedBy!.contains(currentUserId);
  }

  @override
  Widget build(BuildContext context) {
    final _replyCubit = BlocProvider.of<ReplyCubit>(context);

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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AvatarImage(
                      height: size.height * 0.05, profileUrl: profileUrl),
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
                      VoteButton(
                        icon: Icons.thumb_up,
                        isSelected: isUpvoted(upvotedBy, _replyCubit.state.uid),
                        onPress: () {
                          isUpvoted(upvotedBy, _replyCubit.state.uid)
                              ? context.read<ReplyCubit>().decreaseUpvoteReply(
                                  replyId: id,
                                  updatedVote: int.parse(upvotes) - 1)
                              : context.read<ReplyCubit>().upvoteReply(
                                  replyId: id,
                                  updatedVote: int.parse(upvotes) + 1);
                        },
                      ),
                      Text(
                        upvotes,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      VoteButton(
                        icon: Icons.thumb_down,
                        isSelected:
                            isDownvoted(downvotedBy, _replyCubit.state.uid),
                        onPress: () {
                          isDownvoted(
                            downvotedBy,
                            _replyCubit.state.uid,
                          )
                              ? context
                                  .read<ReplyCubit>()
                                  .decreaseDownvoteReply(
                                      replyId: id,
                                      updatedVote: int.parse(downvotes) + 1)
                              : context.read<ReplyCubit>().downvoteReply(
                                  replyId: id,
                                  updatedVote: int.parse(downvotes) - 1);
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
