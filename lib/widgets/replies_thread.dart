import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftc_forum/cubits/users/reply/reply_cubit.dart';
import 'package:ftc_forum/models/reply.dart';
import 'package:ftc_forum/models/user_model.dart';
import 'package:ftc_forum/widgets/reply_card.dart';
import 'package:ftc_forum/widgets/write_comment.dart';

import '../blocs/app/app_bloc.dart';

class RepliesThread extends StatelessWidget {
  final String qid;
  const RepliesThread({
    Key? key,
    required this.qid,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final _appBloc = BlocProvider.of<AppBloc>(context);
    final _replyCubit = BlocProvider.of<ReplyCubit>(context);
    bool isData = false;

    return BlocListener<ReplyCubit, ReplyState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WriteComment(size: size, qid: qid),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _replyCubit.fetchRepliesOfQuestion(qid),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (!snapshot.hasData) {
                  isData = true;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                snapshot.data!.docs.isNotEmpty ? isData = true : isData = false;

                return SizedBox(
                  height: isData ? size.height * 0.6 : size.height * 0.1,
                  child: isData
                      ? ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (_, index) {
                            final doc = snapshot.data!.docs[index];
                            final reply = Reply.fromMap(doc.data(), doc.id);
                            final user = _replyCubit.fetchUserById(reply.uid);
                            return FutureBuilder<User>(
                                future: _replyCubit.fetchUserById(reply.uid),
                                builder: (_, userSnapshot) {
                                  if (userSnapshot.hasError) {
                                    return Center(
                                      child:
                                          Text('Error: ${userSnapshot.error}'),
                                    );
                                  }
                                  if (!userSnapshot.hasData) {
                                    return Center(
                                      child: Container(
                                          margin:
                                              EdgeInsets.all(size.height * 0.1),
                                          child:
                                              const CircularProgressIndicator()),
                                    );
                                  }
                                  return ReplyCard(
                                    id: doc.id,
                                    uid: reply.uid,
                                    qid: qid,
                                    upvotedBy: reply.upVotedBy,
                                    downvotedBy: reply.downVotedBy,
                                    user: user,
                                    reply: reply.description,
                                    date: reply.date as DateTime,
                                    name: userSnapshot.data!.name.toString(),
                                    onPress: () {},
                                    profileUrl:
                                        userSnapshot.data!.photo.toString(),
                                    bgColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    upvotes: reply.upVotes.toString(),
                                    downvotes: reply.downVotes.toString(),
                                  );
                                });
                          },
                        )
                      : const Center(
                          child: Text("No Replies, Be First to add one")),
                );
              }),
        ],
      ),
    );
  }
}
