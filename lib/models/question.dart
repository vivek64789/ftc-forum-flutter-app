import 'package:equatable/equatable.dart';
import 'package:ftc_forum/models/question_category.dart';
import 'package:ftc_forum/models/section.dart';

class Question extends Equatable {
  final String id;
  final String uid;
  final String? title;
  final String? description;
  final DateTime? date;
  final int? upVotes;
  final List<String>? upVotedBy;
  final int? downVotes;
  final List<String>? downVotedBy;
  final int? replyCount;
  final Section? section;
  final QuestionCategory? category;
  final String? imageUrl;

  const Question({
    required this.id,
    required this.uid,
    this.upVotedBy,
    this.downVotedBy,
    this.title,
    this.description,
    this.date,
    this.upVotes,
    this.downVotes,
    this.replyCount,
    this.section,
    this.imageUrl,
    this.category,
  });

  static const empty = Question(id: '', uid: "");

  bool get isEmpty => this == Question.empty;
  bool get isNotEmpty => this != Question.empty;

  @override
  List<Object?> get props => [
        id,
        uid,
        title,
        description,
        date,
        upVotes,
        downVotes,
        replyCount,
        section,
        imageUrl,
        upVotedBy,
        downVotedBy,
        category,
      ];
}
