part of 'category_cubit.dart';

enum CategoryStatus {
  initial,
  loading,
  success,
  error,
}

class CategoryState extends Equatable {
  String categoryName;
  CategoryStatus status;
  CategoryState({required this.categoryName, required this.status});

  @override
  List<Object> get props => [categoryName, status];

  factory CategoryState.initial() {
    return CategoryState(categoryName: "", status: CategoryStatus.initial);
  }

  CategoryState copyWith({
    String? categoryName,
    CategoryStatus? status,
  }) {
    return CategoryState(
        categoryName: categoryName ?? this.categoryName,
        status: status ?? this.status);
  }
}
