import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ftc_forum/models/question_category.dart';
import 'package:ftc_forum/repositories/admin_repository.dart';
import 'package:ftc_forum/widgets/question_card.dart';

part 'admin_section_state.dart';

class AdminSectionCubit extends Cubit<AdminSectionState> {
  AdminRepository _adminRepository;
  AdminSectionCubit(this._adminRepository) : super(AdminSectionState.initial());

  void sectionNameChanged({required String sectionName}) {
    emit(
      state.copyWith(
        sectionName: sectionName,
        status: SectionStatus.initial,
      ),
    );
  }

  void categoryChanged({required QuestionCategory category}) {
    emit(
      state.copyWith(
        category: category,
        status: SectionStatus.initial,
      ),
    );
  }

  void imageUrlChanged({required String imageUrl}) {
    emit(
      state.copyWith(
        imageUrl: imageUrl,
        status: SectionStatus.initial,
      ),
    );
  }

  Future<void> addSection(context) async {
    if (state.status == SectionStatus.loading) return;
    emit(state.copyWith(status: SectionStatus.loading));
    try {
      await _adminRepository.createSection(
          sectionName: state.sectionName,
          category: state.category,
          imageUrl: state.imageUrl);
      emit(state.copyWith(status: SectionStatus.success));
      Navigator.of(context).pop();
      // show snackbar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Section added successfully'),
      ));
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateSection(String id, BuildContext context) async {
    if (state.status == SectionStatus.loading) return;
    emit(state.copyWith(status: SectionStatus.loading));
    try {
      await _adminRepository.updateSection(
        id: id,
        sectionName: state.sectionName,
        category: state.category,
        imageUrl: state.imageUrl,
      );
      emit(state.copyWith(status: SectionStatus.success));
      Navigator.of(context).pop();
      // show snackbar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Section updated successfully'),
      ));
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSections() {
    emit(state.copyWith(status: SectionStatus.loading));
    final result = _adminRepository.fetchSections();
    emit(state.copyWith(status: SectionStatus.success));
    return result;
  }

  Future<void> deleteSection(String id, BuildContext context) async {
    emit(state.copyWith(status: SectionStatus.loading));
    try {
      _adminRepository.deleteSection(id: id);
      emit(state.copyWith(status: SectionStatus.success));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Section deleted successfully'),
      ));
    } catch (e) {
      emit(state.copyWith(status: SectionStatus.success));
    }
  }

  Future<void> uploadImage(context) async {
    if (state.status == SectionStatus.loading) return;
    emit(state.copyWith(status: SectionStatus.loading));
    try {
      await _adminRepository
          .uploadImage(
        id: "${state.sectionName}_${state.category.id}",
        name: "${state.category.id}_${state.sectionName}",
      )
          .then((value) {
        imageUrlChanged(imageUrl: value);
        print("This is url $value");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Image uploaded successfully'),
        ));
        // emit(state.copyWith(status: SectionStatus.success));
      });
    } catch (e) {
      // emit(state.copyWith(status: SectionStatus.success));
    }
  }
}
