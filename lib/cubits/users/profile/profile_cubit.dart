import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ftc_forum/repositories/user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  UserRepository _userRepository;
  ProfileCubit(this._userRepository) : super(ProfileState.initial());

  void uidChanged(String uid) async {
    emit(state.copyWith(uid: uid));
  }

  void imageUrlChanged(String imageUrl) async {
    emit(state.copyWith(photo: imageUrl));
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchUserProfile() {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = _userRepository.fetchUserProfile(state.uid);
    emit(state.copyWith(status: ProfileStatus.success));
    return result;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchUserProfileById(
      String uid) {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = _userRepository.fetchUserProfile(uid);
    emit(state.copyWith(status: ProfileStatus.success));
    return result;
  }

  Future<void> uploadImage(context) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      await _userRepository
          .uploadImage(
        id: "${state.email}_${state.name}",
        name: "${state.name}_${state.uid}",
      )
          .then((value) {
        imageUrlChanged(value);
        _userRepository.updateProfileImageUrl(uid: state.uid, imageUrl: value);
        emit(state.copyWith(status: ProfileStatus.success));
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Image uploaded successfully")));
      });
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.success));
    }
  }
}
