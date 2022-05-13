import 'package:equatable/equatable.dart';

class Section extends Equatable {
  final String id;
  final String? name;
  final String? category;
  final String? imageUrl;

  const Section({required this.id, this.name, this.category, this.imageUrl});

  static const empty = Section(id: '');

  bool get isEmpty => this == Section.empty;
  bool get isNotEmpty => this != Section.empty;

  @override
  List<Object?> get props => [id, name, category, imageUrl];

  static Section fromMap(Map<String, dynamic> map, id) {
    return Section(
      id: id ?? '',
      imageUrl: map['imageUrl'],
      category: map['category'], 
      name: map['name'],
    );
  }
}
