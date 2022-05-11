import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ftc_forum/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginState.initial());

  void emailChanged(String email) {
    emit(state.copyWith(email: email, status: LoginStatus.initial));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password, status: LoginStatus.initial));
  }

  Future<void> loginWithEmailAndPassword() async {
    if (state.status == LoginStatus.loading) return;
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      final result = await _authRepository.logInWithEmailAndPassword(
          email: state.email, password: state.password);

      print("This is my result, $result");

      emit(state.copyWith(status: LoginStatus.success));
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.error));
    }
  }

  Future<void> fetchRole(String uid) async {
    try {
      final result = await _authRepository.getIsAdmin(uid);
      print(result);
      emit(state.copyWith(isAdmin: result));
    } catch (e) {
      print("Error here");
    }
  }
}
