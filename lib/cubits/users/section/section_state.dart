part of 'section_cubit.dart';

enum SectionStatus {
  initial,
  loading,
  success,
  error,
}

class SectionState extends Equatable {
  String sectionName;
  QuestionCategory category;
  String imageUrl;
  List<String> questions;

  SectionStatus status;

  SectionState({
    required this.sectionName,
    required this.status,
    required this.category,
    required this.imageUrl,
    required this.questions,
  });

  @override
  List<Object> get props =>
      [sectionName, status, category, imageUrl, questions];

  factory SectionState.initial() {
    return SectionState(
      sectionName: "",
      status: SectionStatus.initial,
      category: const QuestionCategory(id: "", categoryName: ""),
      imageUrl: "",
      questions: [],
    );
  }

  SectionState copyWith({
    String? sectionName,
    QuestionCategory? category,
    SectionStatus? status,
    String? imageUrl,
    List<String>? questions,
  }) {
    return SectionState(
      sectionName: sectionName ?? this.sectionName,
      category: category ?? this.category,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      questions: questions ?? this.questions,
    );
  }
}
