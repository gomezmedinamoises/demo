// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String description;
  final DateTime createdAt;

  const Report({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory Report.fromMap(Map<String, dynamic> map) {
    //final createdAt = map['createdAt'];
    return Report(
      id: map['id'] as String,
      userId: map['userId'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      createdAt: map['createdAt'] as DateTime,
      //createdAt: createdAt != null ? (createdAt as Timestamp).toDate() : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'title': title,
        'description': description,
        'createdAt': createdAt,
      };

  @override
  List<Object?> get props => [id, userId, title, description];
}
