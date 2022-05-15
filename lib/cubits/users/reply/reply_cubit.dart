import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ftc_forum/models/reply.dart';
import 'package:ftc_forum/models/user_model.dart';
import 'package:ftc_forum/repositories/user_repository.dart';

part 'reply_state.dart';

class ReplyCubit extends Cubit<ReplyState> {
  UserRepository _userRepository;
  ReplyCubit(this._userRepository) : super(ReplyState.initial());

  void uidChanged(String uid) {
    emit(
      state.copyWith(
        uid: uid,
        status: ReplyStatus.initial,
      ),
    );
  }

  void qidChanged(String qid) {
    emit(
      state.copyWith(
        qid: qid,
        status: ReplyStatus.initial,
      ),
    );
  }

  void descriptionChanged(dynamic description) {
    emit(
      state.copyWith(
        jsonDescription: description,
        status: ReplyStatus.initial,
      ),
    );
  }

  Future<void> upvoteReply(
      {required String replyId, required int updatedVote}) async {
    emit(state.copyWith(upvoteStatus: ReplyUpvoteStatus.loading));
    await _userRepository.upvoteReply(
        replyId: replyId, updatedVote: updatedVote, uid: state.uid);
    emit(state.copyWith(upvoteStatus: ReplyUpvoteStatus.success));
  }

  Future<void> downvoteReply(
      {required String replyId, required int updatedVote}) async {
    emit(state.copyWith(downvoteStatus: ReplyDownvoteStatus.loading));
    await _userRepository.downvoteReply(
        replyId: replyId, updatedVote: updatedVote, uid: state.uid);
    emit(state.copyWith(downvoteStatus: ReplyDownvoteStatus.success));
  }

  Future<void> decreaseUpvoteReply(
      {required String replyId, required int updatedVote}) async {
    emit(state.copyWith(upvoteStatus: ReplyUpvoteStatus.loading));
    await _userRepository.decreaseUpvoteReply(
        replyId: replyId, updatedVote: updatedVote, uid: state.uid);
    emit(state.copyWith(upvoteStatus: ReplyUpvoteStatus.success));
  }

  Future<void> decreaseDownvoteReply(
      {required String replyId, required int updatedVote}) async {
    emit(state.copyWith(downvoteStatus: ReplyDownvoteStatus.loading));
    await _userRepository.decreaseDownvoteReply(
        replyId: replyId, updatedVote: updatedVote, uid: state.uid);
    emit(state.copyWith(downvoteStatus: ReplyDownvoteStatus.success));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchRepliesOfQuestion(
      String questionId) {
    emit(state.copyWith(status: ReplyStatus.loading));
    final result = _userRepository.fetchRepliesOfQuestion(questionId);
    emit(state.copyWith(status: ReplyStatus.success));
    return result;
  }

  Future<void> postReply(BuildContext context) async {
    emit(state.copyWith(status: ReplyStatus.loading));
    final result = await _userRepository.createReply(
        reply: Reply(
      id: "",
      uid: state.uid,
      qid: state.qid,
      jsonDescription: state.jsonDescription,
    ));
    emit(state.copyWith(status: ReplyStatus.success));
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Reply Posted Successfully"),
    ));
  }

  Future<void> deleteComment(
      BuildContext context, String rid, String qid) async {
    emit(state.copyWith(status: ReplyStatus.loading));
    final result = await _userRepository.deleteComment(
      id: rid,
      qid: qid,
    );
    emit(state.copyWith(status: ReplyStatus.success));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Reply Deleted Successfully"),
    ));
  }

  Future<void> updatePostReply(BuildContext context, rid) async {
    emit(state.copyWith(status: ReplyStatus.loading));
    final result = await _userRepository.updateReply(
        reply: Reply(
      id: rid,
      uid: state.uid,
      jsonDescription: state.jsonDescription,
    ));
    emit(state.copyWith(status: ReplyStatus.success));
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Reply Updated Successfully"),
    ));
  }

  Future<User> fetchUserById(String id) async {
    emit(state.copyWith(status: ReplyStatus.loading));
    final result = await _userRepository.fetchUserById(id);
    return result;
  }
}
