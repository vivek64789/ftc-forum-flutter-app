part of 'profile_cubit.dart';

enum ProfileStatus {
  initial,
  loading,
  success,
  error,
}

class ProfileState extends Equatable {
  String uid;
  String name;
  String email;
  String photo;
  String dob;
  String phone;
  ProfileStatus status;
  ProfileState({
    required this.uid,
    required this.name,
    required this.email,
    required this.photo,
    required this.dob,
    required this.phone,
    required this.status,
  });

  @override
  List<Object> get props => [
        uid,
        name,
        email,
        photo,
        dob,
        phone,
        status,
      ];

  factory ProfileState.initial() {
    return ProfileState(
      uid: "",
      name: "",
      email: "",
      photo: "",
      dob: "",
      phone: "",
      status: ProfileStatus.initial,
    );
  }

  ProfileState copyWith({
    String? uid,
    String? name,
    String? email,
    String? photo,
    String? dob,
    String? phone,
    ProfileStatus? status,

  }) {
    return ProfileState(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photo: photo ?? this.photo,
      dob: dob ?? this.dob,
      phone: phone ?? this.phone,
      status: status ?? this.status,
    );
  }
}
