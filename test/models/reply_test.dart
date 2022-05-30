import 'package:flutter_test/flutter_test.dart';
import 'package:ftc_forum/models/reply.dart';

void main() {
  final replyCategoryModel = Reply(
      id: "Test",
      uid: "Test",
      qid: "Test",
      jsonDescription: "9818821313",
      date: DateTime(2020),
      upVotes: 3,
      downVotes: 4,
      upVotedBy: [],
      downVotedBy: []);

  test(
    "Should be sub class of Reply entity ",
    () async {
      // assert
      expect(replyCategoryModel, isA<Reply>());
    },
  );
}
