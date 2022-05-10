import 'package:equatable/equatable.dart';
import 'package:ftc_forum/models/question.dart';

class Reply extends Equatable {
  final String id;
  final Question? qid;
  final String? description;
  final String? date;
  final String? upVotes;
  final String? downVotes;
  final List<String>? imageUrl;

  const Reply({
    required this.id,
    this.description,
    this.date,
    this.upVotes,
    this.downVotes,
    this.imageUrl,
    this.qid,
  });

  static const empty = Reply(id: '');

  bool get isEmpty => this == Reply.empty;
  bool get isNotEmpty => this != Reply.empty;

  @override
  List<Object?> get props => [
        id,
        description,
        date,
        upVotes,
        downVotes,
        imageUrl,
        qid,
      ];
}
