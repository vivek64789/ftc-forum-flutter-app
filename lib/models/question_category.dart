import 'package:equatable/equatable.dart';

class QuestionCategory extends Equatable {
  final String id;
  final String? categoryName;

  const QuestionCategory({required this.id, this.categoryName});

  static const empty = QuestionCategory(id: '');

  bool get isEmpty => this == QuestionCategory.empty;
  bool get isNotEmpty => this != QuestionCategory.empty;

  @override
  List<Object?> get props => [id, categoryName];

  static QuestionCategory fromMap(Map<String, dynamic> map, id) {
    return QuestionCategory(
      id: id ?? '',
      categoryName: map['categoryName'],
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryName': categoryName,
    };
  }
}
