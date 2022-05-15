part of 'reply_cubit.dart';

enum ReplyStatus {
  initial,
  loading,
  success,
  error,
}
enum ReplyUpvoteStatus {
  initial,
  loading,
  success,
  error,
}
enum ReplyDownvoteStatus {
  initial,
  loading,
  success,
  error,
}

class ReplyState extends Equatable {
  final String id;
  final String uid;
  final String qid;
  final List<dynamic> description;
  final dynamic jsonDescription;
  final DateTime date;
  final int upVotes;
  final int downVotes;
  final ReplyStatus status;
  final List<String> upVotedBy;
  final List<String> downVotedBy;
  final ReplyUpvoteStatus upvoteStatus;
  final ReplyDownvoteStatus downvoteStatus;

  ReplyState(
      {required this.id,
      required this.uid,
      required this.description,
      required this.date,
      required this.upVotedBy,
      required this.upVotes,
      required this.downVotedBy,
      required this.downVotes,
      required this.qid,
      required this.jsonDescription,
      required this.status,
      required this.upvoteStatus,
      required this.downvoteStatus});

  @override
  List<Object> get props => [
        id,
        uid,
        description,
        date,
        upVotes,
        upVotedBy,
        downVotes,
        downVotedBy,
        qid,
        jsonDescription,
        upvoteStatus,
        downvoteStatus,
      ];

  factory ReplyState.initial() {
    return ReplyState(
      id: '',
      uid: '',
      description: [],
      date: DateTime.now(),
      upVotes: 0,
      upVotedBy: [],
      downVotes: 0,
      downVotedBy: [],
      qid: '',
      jsonDescription: '',
      upvoteStatus: ReplyUpvoteStatus.initial,
      downvoteStatus: ReplyDownvoteStatus.initial,
      status: ReplyStatus.initial,
    );
  }

  ReplyState copyWith({
    String? id,
    String? uid,
    String? qid,
    String? title,
    dynamic description,
    DateTime? date,
    int? upVotes,
    List<String>? upVotedBy,
    int? downVotes,
    List<String>? downVotedBy,
    ReplyUpvoteStatus? upvoteStatus,
    ReplyDownvoteStatus? downvoteStatus,
    dynamic jsonDescription,
    ReplyStatus? status,
  }) {
    return ReplyState(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      description: description ?? this.description,
      date: date ?? this.date,
      upVotes: upVotes ?? this.upVotes,
      upVotedBy: upVotedBy ?? this.upVotedBy,
      downVotes: downVotes ?? this.downVotes,
      downVotedBy: downVotedBy ?? this.downVotedBy,
      status: status ?? this.status,
      upvoteStatus: upvoteStatus ?? this.upvoteStatus,
      downvoteStatus: downvoteStatus ?? this.downvoteStatus,
      jsonDescription: jsonDescription ?? this.jsonDescription,
      qid: qid ?? this.qid,
      
    );
  }
}
