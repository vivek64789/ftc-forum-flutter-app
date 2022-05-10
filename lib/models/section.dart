import 'package:equatable/equatable.dart';
import 'package:ftc_forum/models/question_category.dart';

class Section extends Equatable {
  final String id;
  final String? name;
  final QuestionCategory? category;
  final String? imageUrl;

  const Section({required this.id, this.name, this.category, this.imageUrl});

  static const empty = Section(id: '');

  bool get isEmpty => this == Section.empty;
  bool get isNotEmpty => this != Section.empty;

  @override
  List<Object?> get props => [id, name, category, imageUrl];
}
