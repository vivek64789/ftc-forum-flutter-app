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

  SectionStatus status;

  SectionState(
      {required this.sectionName,
      required this.status,
      required this.category,
      required this.imageUrl});

  @override
  List<Object> get props => [sectionName, status, category];

  factory SectionState.initial() {
    return SectionState(
      sectionName: "",
      status: SectionStatus.initial,
      category: const QuestionCategory(id: "", name: ""),
      imageUrl: "",
    );
  }

  SectionState copyWith({
    String? sectionName,
    QuestionCategory? category,
    SectionStatus? status,
    String? imageUrl,
  }) {
    return SectionState(
      sectionName: sectionName ?? this.sectionName,
      category: category ?? this.category,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
