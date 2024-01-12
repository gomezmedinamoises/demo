// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String description;
  final DateTime? createdAt;
  final String status;

  const Report({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
  });

  factory Report.fromMap(Map<String, dynamic>? map) {
    return Report(
      id: map?['id'] ?? '',
      userId: map?['userId'] ?? '',
      title: map?['title'] ?? '',
      description: map?['description'] ?? '',
      //createdAt: map?['createdAt'] ?? '',
      status: map?['status'] ?? '',
      createdAt: map?['createdAt'] != null
          ? (map?['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'title': title,
        'description': description,
        if (createdAt != null) 'createdAt': Timestamp.fromDate(createdAt!),
        'status': status,
      };

  @override
  List<Object?> get props =>
      [id, userId, title, description, createdAt, status];
}
