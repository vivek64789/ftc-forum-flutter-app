import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ftc_forum/models/section.dart';
import 'package:ftc_forum/models/user_model.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  const sectionModel = Section(
    category: 'Test',
    imageUrl: 'Test',
    name: "Test",
    id: "Test",
  );

  test(
    "Should be sub class of Section entity ",
    () async {
      // assert
      expect(sectionModel, isA<Section>());
    },
  );

  group(
    "From Json",
    () {
      test(
        "Should should return Section entity when provided json data",
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              jsonDecode(fixture('section.json'));

          // act
          final result = Section.fromMap(jsonMap,'Test');

          // assert
          expect(result, sectionModel);
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
          final sectionMap = jsonDecode(fixture('section.json'));

          // act
          final result = sectionModel.toMap();

          // assert
          expect(result, sectionMap);
        },
      );
    },
  );
}
