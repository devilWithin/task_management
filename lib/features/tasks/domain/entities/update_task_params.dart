import 'package:equatable/equatable.dart';
import 'package:task_management_test/features/tasks/data/models/update_task_params_model.dart';

class UpdateTaskParams extends Equatable {
  final String id;
  final String? description;
  final String? title;
  final DateTime? dueDate;

  const UpdateTaskParams({
    required this.id,
    this.description,
    this.title,
    this.dueDate,
  });

  @override
  List<Object?> get props => [id, description, title, dueDate];
}

extension UpdateTaskParamsX on UpdateTaskParams {
  UpdateTaskParamsModel toData() => UpdateTaskParamsModel(
        id: id,
        description: description,
        title: title,
        dueDate: dueDate,
      );
}
