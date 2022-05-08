part of 'register_cubit.dart';

enum RegisterStatus {
  initial,
  loading,
  success,
  error,
}

class RegisterState extends Equatable {
  final String email;
  final String password;
  final String phone;
  final String dob;
  final String name;
  final RegisterStatus status;
  const RegisterState({
    required this.name,
    required this.dob,
    required this.phone,
    required this.email,
    required this.password,
    required this.status,
  });

  @override
  List<Object> get props => [email, password, status];

  factory RegisterState.initial() {
    return const RegisterState(
      phone: '',
      name: '',
      dob: '',
      email: '',
      password: '',
      status: RegisterStatus.initial,
    );
  }

  RegisterState copyWith({
    String? name,
    String? dob,
    String? phone,
    String? email,
    String? password,
    RegisterStatus? status,
  }) {
    return RegisterState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
