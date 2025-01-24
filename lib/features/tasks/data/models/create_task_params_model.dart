import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CreateTaskParamsModel extends Equatable {
  final String title;
  final String description;
  final DateTime dueDate;
  final int status;

  const CreateTaskParamsModel({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
  });

  @override
  List<Object?> get props => [title, description, dueDate, status];

  Map<String, dynamic> toJson() {
    return {
      'id': '',
      'title': title,
      'description': description,
      'due_date': Timestamp.fromDate(dueDate),
      'status': 0,
    };
  }
}
