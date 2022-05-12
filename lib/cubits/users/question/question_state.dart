part of 'question_cubit.dart';

enum QuestionStatus {
  initial,
  loading,
  success,
  error,
}
enum UpvoteStatus {
  initial,
  loading,
  success,
  error,
}
enum DownvoteStatus {
  initial,
  loading,
  success,
  error,
}

class QuestionState extends Equatable {
  final String id;
  final String uid;
  final String title;
  final dynamic description;
  final DateTime date;
  final int upVotes;
  final List<String> upVotedBy;
  final int downVotes;
  final List<String> downVotedBy;
  final int replyCount;
  final Section section;
  final QuestionCategory category;
  final String imageUrl;
  final String selectedCategoryId;
  final String selectedSectionId;
  QuestionStatus status;
  UpvoteStatus upvoteStatus;
  DownvoteStatus downvoteStatus;
  QuestionState(
      {required this.id,
      required this.uid,
      required this.title,
      required this.description,
      required this.date,
      required this.upVotedBy,
      required this.upVotes,
      required this.downVotedBy,
      required this.downVotes,
      required this.replyCount,
      required this.section,
      required this.category,
      required this.imageUrl,
      required this.status,
      required this.downvoteStatus,
      required this.upvoteStatus,
      required this.selectedCategoryId,
      required this.selectedSectionId});

  @override
  List<Object> get props => [
        id,
        uid,
        title,
        description,
        date,
        upVotes,
        upVotedBy,
        downVotes,
        downVotedBy,
        replyCount,
        section,
        category,
        imageUrl,
        status,
        downvoteStatus,
        upvoteStatus,
        selectedCategoryId,
        selectedSectionId
      ];

  factory QuestionState.initial() {
    return QuestionState(
        id: '',
        uid: '',
        title: '',
        description: '',
        date: DateTime.now(),
        upVotes: 0,
        upVotedBy: [],
        downVotes: 0,
        downVotedBy: [],
        replyCount: 0,
        section: Section.empty,
        category: QuestionCategory.empty,
        imageUrl: "",
        status: QuestionStatus.initial,
        upvoteStatus: UpvoteStatus.initial,
        downvoteStatus: DownvoteStatus.initial,
        selectedCategoryId: '',
        selectedSectionId: '');
  }

  QuestionState copyWith({
    String? id,
    String? uid,
    String? title,
    dynamic description,
    DateTime? date,
    int? upVotes,
    List<String>? upVotedBy,
    int? downVotes,
    List<String>? downVotedBy,
    int? replyCount,
    Section? section,
    QuestionCategory? category,
    String? imageUrl,
    QuestionStatus? status,
    UpvoteStatus? upvoteStatus,
    DownvoteStatus? downvoteStatus,
    String? selectedCategoryId,
    String? selectedSectionId,
  }) {
    return QuestionState(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      upVotes: upVotes ?? this.upVotes,
      upVotedBy: upVotedBy ?? this.upVotedBy,
      downVotes: downVotes ?? this.downVotes,
      downVotedBy: downVotedBy ?? this.downVotedBy,
      replyCount: replyCount ?? this.replyCount,
      section: section ?? this.section,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
      upvoteStatus: upvoteStatus ?? this.upvoteStatus,
      downvoteStatus: downvoteStatus ?? this.downvoteStatus,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedSectionId: selectedSectionId ?? this.selectedSectionId,
    );
  }
}
