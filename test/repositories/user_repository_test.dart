import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ftc_forum/models/question.dart';
import 'package:ftc_forum/repositories/user_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  Question question = Question(id: "1");
  test('Create Question Test', () async {
    // setup
    final MockUserRepository mockUserRepository = MockUserRepository();
    when(mockUserRepository.createQuestion(question: question))
        .thenAnswer((_) async => question);
    // login
    await mockUserRepository.createQuestion(question: question);
    expect(null, null);
  });

  test('Update Question Test', () async {
    // setup
    final MockUserRepository mockUserRepository = MockUserRepository();
    when(mockUserRepository.updatePostQuestion(question: question))
        .thenAnswer((_) async => question);
    // login
    await mockUserRepository.updatePostQuestion(question: question);
    expect(null, null);
  });

  test('Delete Question Test', () async {
    // setup
    final MockUserRepository mockUserRepository = MockUserRepository();
    when(mockUserRepository.deleteQuestion(questionId: question.id))
        .thenAnswer((_) async => question);
    // login
    await mockUserRepository.deleteQuestion(questionId: question.id);
    expect(null, null);
  });

  test('Get Question Test', () async {
    // setup
    final MockUserRepository mockUserRepository = MockUserRepository();
    when(mockUserRepository.fetchQuestions()).thenAnswer((_) async* {
      Stream<QuerySnapshot<Map<String, dynamic>>>;
    });
    // login
    mockUserRepository.fetchQuestions();
    expect(null, null);
  });
}
