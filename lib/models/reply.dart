import 'dart:convert';

import 'package:equatable/equatable.dart';

class Reply extends Equatable {
  final String id;
  final String uid;
  final String? qid;
  final List<dynamic>? description;
  final String? jsonDescription;
  final DateTime? date;
  final int? upVotes;
  final int? downVotes;
  final List<String>? upVotedBy;
  final List<String>? downVotedBy;

  const Reply({
    required this.id,
    required this.uid,
    this.description,
    this.date,
    this.upVotes,
    this.downVotes,
    this.jsonDescription,
    this.upVotedBy,
    this.downVotedBy,
    this.qid,
  });

  static const empty = Reply(id: '', uid: '');

  bool get isEmpty => this == Reply.empty;
  bool get isNotEmpty => this != Reply.empty;

  @override
  List<Object?> get props => [
        id,
        description,
        date,
        upVotes,
        downVotes,
        qid,
        uid,
        jsonDescription,
        upVotedBy,
        downVotedBy,
      ];

  static Reply fromMap(Map<String, dynamic> map, id) {
    return Reply(
      id: id ?? '',
      uid: map['uid'] ?? '',
      description: jsonDecode(map['description']) as List<dynamic>,
      date: DateTime.fromMicrosecondsSinceEpoch(map['date'].seconds * 1000000),
      upVotes: map['upvotes'],
      downVotes: map['downvotes'],
      upVotedBy: map['upVotedBy']?.cast<String>(),
      downVotedBy: map['downVotedBy']?.cast<String>(),
      jsonDescription: map['jsonDescription'],
      qid: map['qid'], 
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'description': jsonEncode(description),
      'date': date?.microsecondsSinceEpoch,
      'upVotes': upVotes,
      'downVotes': downVotes,
      'upVotedBy': upVotedBy,
      'downVotedBy': downVotedBy,
      'qid': qid,
      'jsonDescription': jsonDescription,
    };
  }
}
