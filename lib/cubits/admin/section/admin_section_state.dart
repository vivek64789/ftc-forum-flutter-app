part of 'admin_section_cubit.dart';

enum SectionStatus {
  initial,
  loading,
  success,
  error,
}

class AdminSectionState extends Equatable {
  String sectionName;
  QuestionCategory category;
  String imageUrl;

  SectionStatus status;

  AdminSectionState(
      {required this.sectionName,
      required this.status,
      required this.category,
      required this.imageUrl});

  @override
  List<Object> get props => [sectionName, status, category, imageUrl];

  factory AdminSectionState.initial() {
    return AdminSectionState(
      sectionName: "",
      status: SectionStatus.initial,
      category: const QuestionCategory(id: "", categoryName: ""),
      imageUrl: "",
    );
  }

  AdminSectionState copyWith({
    String? sectionName,
    QuestionCategory? category,
    SectionStatus? status,
    String? imageUrl,
  }) {
    return AdminSectionState(
      sectionName: sectionName ?? this.sectionName,
      category: category ?? this.category,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
