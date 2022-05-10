import 'package:equatable/equatable.dart';

class QuestionCategory extends Equatable {
  final String id;
  final String? name;

  const QuestionCategory({required this.id, this.name});

  static const empty = QuestionCategory(id: '');

  bool get isEmpty => this == QuestionCategory.empty;
  bool get isNotEmpty => this != QuestionCategory.empty;

  @override
  List<Object?> get props => [id, name];
}
