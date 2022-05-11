part of 'login_cubit.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  error,
}

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final bool isAdmin;
  const LoginState({
    required this.email,
    required this.password,
    required this.status,
    this.isAdmin = false,
  });

  @override
  List<Object> get props => [email, password, status, isAdmin];

  factory LoginState.initial() {
    return const LoginState(
      email: '',
      password: '',
      isAdmin: false,
      status: LoginStatus.initial,
    );
  }

  LoginState copyWith({
    String? email,
    String? password,
    bool? isAdmin,
    LoginStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }
}
