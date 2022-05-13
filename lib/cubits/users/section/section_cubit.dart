import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ftc_forum/models/question_category.dart';
import 'package:ftc_forum/models/section.dart';
import 'package:ftc_forum/repositories/user_repository.dart';

part 'section_state.dart';

class SectionCubit extends Cubit<SectionState> {
  UserRepository _userRepository;
  SectionCubit(this._userRepository) : super(SectionState.initial());

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSections() {
    emit(state.copyWith(status: SectionStatus.loading));
    final result = _userRepository.fetchSections();
    emit(state.copyWith(status: SectionStatus.success));
    return result;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchSectionById(
      String sectionId) {
    emit(state.copyWith(status: SectionStatus.loading));
    final result = _userRepository.fetchSectionById(sectionId);
    emit(state.copyWith(status: SectionStatus.success));
    return result;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSectionsByCategoryId(
      String categoryId) {
    emit(state.copyWith(status: SectionStatus.loading));
    final result = _userRepository.fetchSectionsByCategoryId(categoryId);
    emit(state.copyWith(status: SectionStatus.success));
    return result;
  }

  Future<void> uploadImage() async {
    emit(state.copyWith(status: SectionStatus.loading));
    try {
      await _userRepository
          .uploadImage(
        id: "${state.sectionName}_${state.category.id}",
        name: "${state.category.id}_${state.sectionName}",
      )
          .then((value) {
        print("This is url $value");
        emit(state.copyWith(status: SectionStatus.success));
      });
    } catch (e) {
      emit(state.copyWith(status: SectionStatus.success));
    }
  }
}
