import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final int status;
  final DateTime dueDate;

  const TaskEntity({
    required this.status,
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
  });

  @override
  List<Object?> get props => [title, description, dueDate, id, status];
}
