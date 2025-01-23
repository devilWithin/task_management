import 'package:equatable/equatable.dart';
import 'package:task_management_test/features/tasks/data/models/status_model.dart';

class CreateTaskParamsModel extends Equatable {
  final String title;
  final String description;
  final DateTime dueDate;
  final StatusModel status;

  const CreateTaskParamsModel({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
  });

  @override
  List<Object?> get props => [title, description, dueDate];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'due_date': dueDate,
      'status': StatusModel(id: 0, name: 'todo').toJson(),
    };
  }
}
