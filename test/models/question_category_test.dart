import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ftc_forum/models/question_category.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  const questionCategoryModel =
      QuestionCategory(id: 'Test', categoryName: 'Test');

  test(
    "Should be sub class of Question Category entity ",
    () async {
      // assert
      expect(questionCategoryModel, isA<QuestionCategory>());
    },
  );

  group(
    "From Json",
    () {
      test(
        "Should should return User entity when provided json data",
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              jsonDecode(fixture('question_category.json'));

          // act
          final result = QuestionCategory.fromMap(jsonMap, 'Test');

          // assert
          expect(result, questionCategoryModel);
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
          final questionCategoryMap =
              jsonDecode(fixture('question_category.json'));

          // act
          final result = questionCategoryModel.toMap();

          // assert
          expect(result, questionCategoryMap);
        },
      );
    },
  );
}
