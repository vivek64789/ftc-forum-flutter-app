part of 'register_cubit.dart';

enum RegisterStatus {
  initial,
  loading,
  success,
  error,
}

class RegisterState extends Equatable {
  String email;
  String password;
  String phone;
  String dob;
  String name;
  RegisterStatus status;
  RegisterState({
    required this.name,
    required this.dob,
    required this.phone,
    required this.email,
    required this.password,
    required this.status,
  });

  @override
  List<Object> get props => [email, password, status, name, dob, phone];

  factory RegisterState.initial() {
    return RegisterState(
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
