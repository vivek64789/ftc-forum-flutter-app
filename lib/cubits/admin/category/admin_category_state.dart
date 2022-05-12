part of 'admin_category_cubit.dart';

enum CategoryStatus {
  initial,
  loading,
  success,
  error,
}

class AdminCategoryState extends Equatable {
  String categoryName;
  CategoryStatus status;
  AdminCategoryState({required this.categoryName, required this.status});

  @override
  List<Object> get props => [categoryName, status];

  factory AdminCategoryState.initial() {
    return AdminCategoryState(categoryName: "", status: CategoryStatus.initial);
  }

  AdminCategoryState copyWith({
    String? categoryName,
    CategoryStatus? status,
  }) {
    return AdminCategoryState(
        categoryName: categoryName ?? this.categoryName,
        status: status ?? this.status);
  }
}
