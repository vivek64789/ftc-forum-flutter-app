import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ftc_forum/repositories/admin_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  AdminRepository _adminRepository;
  CategoryCubit(this._adminRepository) : super(CategoryState.initial());

  void categoryNameChanged(String categoryName) {
    emit(
      state.copyWith(
        categoryName: categoryName,
        status: CategoryStatus.initial,
      ),
    );
  }

  Future<void> addCategory(context) async {
    if (state.status == CategoryStatus.loading) return;
    emit(state.copyWith(status: CategoryStatus.loading));
    try {
      await _adminRepository.createCategory(categoryName: state.categoryName);
      emit(state.copyWith(status: CategoryStatus.success));
      Navigator.of(context).pop();
      // show snackbar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Category added successfully'),
      ));
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateCategory(String id, BuildContext context) async {
    if (state.status == CategoryStatus.loading) return;
    emit(state.copyWith(status: CategoryStatus.loading));
    try {
      await _adminRepository.updateCategory(
          id: id, categoryName: state.categoryName);
      emit(state.copyWith(status: CategoryStatus.success));
      Navigator.of(context).pop();
      // show snackbar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Category updated successfully'),
      ));
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchCategories() {
    emit(state.copyWith(status: CategoryStatus.loading));
    final result = _adminRepository.fetchCategories();
    emit(state.copyWith(status: CategoryStatus.success));
    return result;
  }

  Future<void> deleteCategory(String id, BuildContext context) async {
    emit(state.copyWith(status: CategoryStatus.loading));
    try {
      _adminRepository.deleteCategory(id: id);
      emit(state.copyWith(status: CategoryStatus.success));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Category deleted successfully'),
      ));
    } catch (e) {
      emit(state.copyWith(status: CategoryStatus.success));
    }
  }
}
