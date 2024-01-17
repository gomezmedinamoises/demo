// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String description;
  final DateTime? createdAt;
  final String status;
  final List<File>? imageUrls;

  const Report({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
    required this.imageUrls,
  });

  factory Report.fromMap(Map<String, dynamic>? map) {
    List<File>? files = (map?['imageUrls'] as List?)?.map((item) {
      return File(item as String);
    }).toList();
    return Report(
      id: map?['id'] ?? '',
      userId: map?['userId'] ?? '',
      title: map?['title'],
      description: map?['description'],
      status: map?['status'] ?? '',
      createdAt: map?['createdAt'] != null
          ? (map?['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      imageUrls: files,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'title': title,
        'description': description,
        if (createdAt != null) 'createdAt': Timestamp.fromDate(createdAt!),
        'status': status,
        'imageUrls': imageUrls,
      };

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        description,
        createdAt,
        status,
        imageUrls,
      ];
}
