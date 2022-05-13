part of 'category_cubit.dart';

enum CategoryStatus {
  initial,
  loading,
  success,
  error,
}

class CategoryState extends Equatable {
  String categoryName;
  List<String> sections;
  CategoryStatus status;
  CategoryState(
      {required this.categoryName,
      required this.status,
      required this.sections});

  @override
  List<Object> get props => [categoryName, status, sections];

  factory CategoryState.initial() {
    return CategoryState(
        categoryName: "", status: CategoryStatus.initial, sections: []);
  }

  CategoryState copyWith({
    String? categoryName,
    CategoryStatus? status,
    List<String>? sections,
  }) {
    return CategoryState(
      categoryName: categoryName ?? this.categoryName,
      status: status ?? this.status,
      sections: sections ?? this.sections,
    );
  }
}
