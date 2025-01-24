import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:task_management_test/features/tasks/domain/entities/task_entity.dart';

class TaskModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final int status;
  final Timestamp dueDate;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.dueDate,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      dueDate: json['due_date'],
    );
  }

  @override
  List<Object?> get props => [title, description, status, dueDate, id];
}

extension TaskModelX on TaskModel {
  TaskEntity toDomain() => TaskEntity(
        id: id,
        title: title,
        description: description,
        status: status,
        dueDate: dueDate.toDate(),
      );
}
