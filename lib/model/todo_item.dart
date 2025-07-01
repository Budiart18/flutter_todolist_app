// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TodoItem {
  final String? id;
  final String title;
  final String description;
  final bool isDone;
  TodoItem({
    this.id,
    required this.title,
    required this.description,
    required this.isDone,
  });

  TodoItem copyWith({
    String? id,
    String? title,
    String? description,
    bool? isDone,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }

  factory TodoItem.fromMap(Map<String, dynamic> map) {
    return TodoItem(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] as String,
      description: map['description'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoItem.fromJson(String source) =>
      TodoItem.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'TodoItem(id: $id, title: $title, description: $description, isDone: $isDone)';
  }

  @override
  bool operator ==(covariant TodoItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.isDone == isDone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        isDone.hashCode;
  }
}
