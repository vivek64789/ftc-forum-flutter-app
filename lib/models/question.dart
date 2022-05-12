import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:ftc_forum/models/question_category.dart';
import 'package:ftc_forum/models/section.dart';

class Question extends Equatable {
  final String id;
  final String uid;
  final String? title;
  final List<dynamic>? description;
  final String? jsonDescription;
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
    this.jsonDescription,
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
        jsonDescription,
      ];

  static Question fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['uid'] ?? '',
      uid: map['uid'] ?? '',
      title: map['title'] ?? '',
      description: jsonDecode(map['description']) as List<dynamic>,
      date: DateTime.fromMicrosecondsSinceEpoch(map['date'].seconds * 1000000),
      upVotes: map['upVotes'] ?? 0,
      downVotes: map['downVotes'] ?? 0,
      replyCount: map['replyCount'] ?? 0,
    );
  }
}
