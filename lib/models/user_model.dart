import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? name;
  final String? dob;
  final String? photo;
  final String? role;
  final String? email;
  final String? phone;

  const User(
      {required this.id,
      this.name,
      this.dob,
      this.photo,
      this.role,
      this.email,
      this.phone});

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [id, name, dob, photo, role, email, phone];

  static User fromJson(Map<String, dynamic>? json) {
    return User(
      id: json!['uid'] as String,
      name: json['name'] as String?,
      dob: json['dob'] as String?,
      photo: json['photo'] as String?,
      role: json['role'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": id,
      "name": name,
      "dob": dob,
      "photo": photo,
      "role": role,
      "email": email,
      "phone": phone,
    };
  }
}
