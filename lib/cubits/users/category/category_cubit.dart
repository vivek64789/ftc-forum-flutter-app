import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ftc_forum/models/section.dart';
import 'package:ftc_forum/repositories/user_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  UserRepository _userRepository;
  CategoryCubit(this._userRepository) : super(CategoryState.initial());



  Stream<QuerySnapshot<Map<String, dynamic>>> fetchCategories() {
    emit(state.copyWith(status: CategoryStatus.loading));
    final result = _userRepository.fetchCategories();
    emit(state.copyWith(status: CategoryStatus.success));
    return result;
  }

  
}
