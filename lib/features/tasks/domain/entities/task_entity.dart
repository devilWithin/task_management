import 'package:equatable/equatable.dart';
import 'package:task_management_test/features/tasks/domain/entities/status.dart';

class TaskEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final Status status;
  final DateTime dueDate;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.dueDate,
  });

  @override
  List<Object?> get props => [title, description, status, dueDate, id];
}
