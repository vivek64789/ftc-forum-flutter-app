import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ftc_forum/repositories/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  AuthRepository _authRepository;
  RegisterCubit(this._authRepository) : super(RegisterState.initial());

  void emailChanged(String email) {
    emit(state.copyWith(email: email, status: RegisterStatus.initial));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password, status: RegisterStatus.initial));
  }

  void nameChanged(String name) {
    emit(state.copyWith(name: name, status: RegisterStatus.initial));
    // emit(state.copyWith(name: name, status: RegisterStatus.initial));
  }

  void phoneChanged(String phone) {
    emit(state.copyWith(phone: phone, status: RegisterStatus.initial));
  }

  void dobChanged(String dob) {
    emit(state.copyWith(dob: dob, status: RegisterStatus.initial));
  }

  Future<void> registerWithEmailAndPassword() async {
    if (state.status == RegisterStatus.loading) return;
    emit(state.copyWith(status: RegisterStatus.loading));
    try {
      await _authRepository.signup(
        email: state.email,
        password: state.password,
        name: state.name,
        phone: state.phone,
        dob: state.dob,
      );
      emit(state.copyWith(status: RegisterStatus.success));
    } catch (_) {
      emit(state.copyWith(status: RegisterStatus.error));
    }
  }
}
