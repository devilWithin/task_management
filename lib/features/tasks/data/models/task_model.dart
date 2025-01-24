import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:task_management_test/features/tasks/domain/entities/task_entity.dart';

import 'status_model.dart';

class TaskModel extends Equatable {
  final String title;
  final String description;
  final StatusModel status;
  final Timestamp dueDate;

  const TaskModel({
    required this.title,
    required this.description,
    required this.status,
    required this.dueDate,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'],
      description: json['description'],
      status: StatusModel.fromJson(json['status']),
      dueDate: json['due_date'],
    );
  }

  @override
  List<Object?> get props => [title, description, status, dueDate];
}

extension TaskModelX on TaskModel {
  TaskEntity toDomain() => TaskEntity(
        title: title,
        description: description,
        status: status.toDomain(),
        dueDate: DateFormat('y MMM d hh:mm:ss a').format(dueDate.toDate()),
      );
}
