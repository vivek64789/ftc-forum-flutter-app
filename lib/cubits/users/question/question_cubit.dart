import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ftc_forum/models/question.dart';
import 'package:ftc_forum/models/question_category.dart';
import 'package:ftc_forum/models/section.dart';
import 'package:ftc_forum/models/user_model.dart';
import 'package:ftc_forum/repositories/user_repository.dart';

part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  UserRepository _userRepository;
  QuestionCubit(this._userRepository) : super(QuestionState.initial());

  void categoryChanged(QuestionCategory category) {
    emit(
      state.copyWith(
        category: category,
        status: QuestionStatus.initial,
      ),
    );
  }

  void selectedCategoryIdChanged(String selectedCategoryId) {
    emit(
      state.copyWith(
        selectedCategoryId: selectedCategoryId,
        category: QuestionCategory(id: selectedCategoryId),
        status: QuestionStatus.initial,
      ),
    );
  }

  void uidChanged(String uid) {
    emit(
      state.copyWith(
        uid: uid,
        status: QuestionStatus.initial,
      ),
    );
  }

  void selectedSectionIdChanged(String selectedSectionId) {
    emit(
      state.copyWith(
        selectedSectionId: selectedSectionId,
        section: Section(id: selectedSectionId),
        status: QuestionStatus.initial,
      ),
    );
  }

  void sectionChanged(Section section) {
    emit(
      state.copyWith(
        section: section,
        status: QuestionStatus.initial,
      ),
    );
  }

  void titleChanged(String title) {
    emit(
      state.copyWith(
        title: title,
        status: QuestionStatus.initial,
      ),
    );
  }

  void descriptionChanged(dynamic description) {
    emit(
      state.copyWith(
        description: description,
        status: QuestionStatus.initial,
      ),
    );
  }

  void imageUrlChanged(String imageUrl) {
    emit(
      state.copyWith(
        imageUrl: imageUrl,
        status: QuestionStatus.initial,
      ),
    );
  }

  Future<void> upvoteQuestion(
      {required String questionId, required int updatedVote}) async {
    emit(state.copyWith(upvoteStatus: UpvoteStatus.loading));
    await _userRepository.upvoteQuestion(
        questionId: questionId, updatedVote: updatedVote, uid: state.uid);
    emit(state.copyWith(upvoteStatus: UpvoteStatus.success));
  }

  Future<void> deleteQuestion(BuildContext context,
      {required String questionId}) async {
    emit(state.copyWith(status: QuestionStatus.loading));
    await _userRepository.deleteQuestion(questionId: questionId);

    emit(state.copyWith(status: QuestionStatus.success));
  }

  Future<void> decreaseUpvoteQuestion(
      {required String questionId, required int updatedVote}) async {
    emit(state.copyWith(upvoteStatus: UpvoteStatus.loading));
    await _userRepository.decreaseUpvoteQuestion(
        questionId: questionId, updatedVote: updatedVote, uid: state.uid);
    emit(state.copyWith(upvoteStatus: UpvoteStatus.success));
  }

  Future<void> decreaseDownvoteQuestion(
      {required String questionId, required int updatedVote}) async {
    emit(state.copyWith(downvoteStatus: DownvoteStatus.loading));
    await _userRepository.decreaseDownvoteQuestion(
        questionId: questionId, updatedVote: updatedVote, uid: state.uid);
    emit(state.copyWith(downvoteStatus: DownvoteStatus.success));
  }

  Future<void> downvoteQuestion(
      {required String questionId, required int updatedVote}) async {
    emit(state.copyWith(downvoteStatus: DownvoteStatus.loading));
    await _userRepository.downvoteQuestion(
        questionId: questionId, updatedVote: updatedVote, uid: state.uid);
    emit(state.copyWith(downvoteStatus: DownvoteStatus.success));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchCategories() {
    emit(state.copyWith(status: QuestionStatus.loading));
    final result = _userRepository.fetchCategories();
    emit(state.copyWith(status: QuestionStatus.success));
    return result;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchCategoryById(
      String categoryId) async {
    emit(state.copyWith(status: QuestionStatus.loading));
    final result = await _userRepository.fetchCategoryById(categoryId);
    emit(state.copyWith(status: QuestionStatus.success));
    return result;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchQuestions() {
    emit(state.copyWith(status: QuestionStatus.loading));
    final result = _userRepository.fetchQuestions();
    emit(state.copyWith(status: QuestionStatus.success));
    return result;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchQuestionsBySectionId(
      String sectionId) {
    emit(state.copyWith(status: QuestionStatus.loading));
    final result = _userRepository.fetchQuestionsBySectionId(sectionId);
    emit(state.copyWith(status: QuestionStatus.success));
    return result;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchTotalQuestionsByUserId(
      String uid) {
    emit(state.copyWith(status: QuestionStatus.loading));
    final result = _userRepository.fetchTotalQuestionsByUserId(uid);
    emit(state.copyWith(status: QuestionStatus.success));
    return result;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSectionsByCategoryId() {
    emit(state.copyWith(status: QuestionStatus.loading));
    final result =
        _userRepository.fetchSectionsByCategoryId(state.selectedCategoryId);
    emit(state.copyWith(status: QuestionStatus.success));
    return result;
  }

  Future<void> postQuestion(BuildContext context) async {
    if (state.category.id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("You must select category"),
      ));
    } else if (state.section.id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("You must select section"),
      ));
    } else if (state.title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("You must enter title"),
      ));
    } else {
      emit(state.copyWith(status: QuestionStatus.loading));
      final result = await _userRepository.createQuestion(
          question: Question(
        id: "",
        uid: state.uid,
        title: state.title,
        jsonDescription: state.description,
        date: DateTime.now(),
        section: state.section,
        category: state.category,
        imageUrl: state.imageUrl,
        upVotedBy: [],
        downVotedBy: [],
        upVotes: 0,
        downVotes: 0,
        replyCount: 0,
      ));
      emit(state.copyWith(status: QuestionStatus.success));
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Question Posted Successfully"),
      ));
    }
  }

  Future<void> updatePostQuestion(BuildContext context, qid) async {
    emit(state.copyWith(status: QuestionStatus.loading));
    final result = await _userRepository.updatePostQuestion(
        question: Question(
      id: qid,
      uid: state.uid,
      title: state.title,
      jsonDescription: state.description,
      section: state.section,
      category: state.category,
      imageUrl: state.imageUrl,
    ));
    emit(state.copyWith(status: QuestionStatus.success));
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Question Posted Successfully"),
    ));
  }

  Future<User> fetchUserById(String id) async {
    emit(state.copyWith(status: QuestionStatus.loading));
    final result = await _userRepository.fetchUserById(id);
    return result;
  }

  Future<void> uploadImage(context) async {
    emit(state.copyWith(status: QuestionStatus.loading));
    try {
      await _userRepository
          .uploadImage(
        id: "${state.title}_${state.category.id}",
        name: "${state.category.id}_${state.title}",
      )
          .then((value) {
        imageUrlChanged(value);
        emit(state.copyWith(status: QuestionStatus.success));
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Image uploaded successfully")));
      });
    } catch (e) {
      emit(state.copyWith(status: QuestionStatus.success));
    }
  }
}
