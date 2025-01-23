import 'package:equatable/equatable.dart';
import 'package:task_management_test/features/tasks/data/models/update_task_params_model.dart';
import 'package:task_management_test/features/tasks/domain/entities/status.dart';

class UpdateTaskParams extends Equatable {
  final int id;
  final String? description;
  final String? title;
  final Status? status;
  final DateTime? dueDate;

  const UpdateTaskParams({
    required this.id,
    this.description,
    this.title,
    this.status,
    this.dueDate,
  });

  @override
  List<Object?> get props => [id, description, title, status, dueDate];
}

extension UpdateTaskParamsX on UpdateTaskParams {
  UpdateTaskParamsModel toData() => UpdateTaskParamsModel(
        id: id,
        description: description,
        title: title,
        status: status?.toData(),
        dueDate: dueDate,
      );
}
