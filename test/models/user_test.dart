import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ftc_forum/models/user_model.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  const userModel = User(
    phone: "9818821313",
    email: "test@gmail.com",
    role: "admin",
    photo: "user",
    dob: "accessToken",
    name: "message",
    id: "skejfslk",
  );

  test(
    "Should be sub class of User entity ",
    () async {
      // assert
      expect(userModel, isA<User>());
    },
  );

  group(
    "From Json",
    () {
      test(
        "Should should return User entity when provided json data",
        () async {
          // arrange
          final Map<String, dynamic> jsonMap = jsonDecode(fixture('user.json'));

          // act
          final result = User.fromJson(jsonMap);

          // assert
          expect(result, userModel);
        },
      );
    },
  );

  group(
    "To Json",
    () {
      test(
        "Should should return Map of String and dynamic when passed User entity",
        () async {
          // arrange
          final userMap = jsonDecode(fixture('user.json'));

          // act
          final result = userModel.toJson();

          // assert
          expect(result, userMap);
        },
      );
    },
  );
}
