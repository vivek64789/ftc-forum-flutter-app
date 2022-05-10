import 'package:equatable/equatable.dart';
import 'package:ftc_forum/models/section.dart';

class Question extends Equatable {
  final String id;
  final String? title;
  final String? description;
  final String? date;
  final String? upVotes;
  final String? downVotes;
  final String? replyCount;
  final Section? section;
  final List<String>? imageUrl;

  const Question({
    required this.id,
    this.title,
    this.description,
    this.date,
    this.upVotes,
    this.downVotes,
    this.replyCount,
    this.section,
    this.imageUrl,
  });

  static const empty = Question(id: '');

  bool get isEmpty => this == Question.empty;
  bool get isNotEmpty => this != Question.empty;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        date,
        upVotes,
        downVotes,
        replyCount,
        section,
        imageUrl
      ];
}
