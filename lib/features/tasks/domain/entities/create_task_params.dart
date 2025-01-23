import 'package:equatable/equatable.dart';
import 'package:task_management_test/features/tasks/data/models/create_task_params_model.dart';
import 'package:task_management_test/features/tasks/domain/entities/status.dart';

class CreateTaskParams extends Equatable {
  final String title;
  final String description;
  final DateTime dueDate;

  const CreateTaskParams({
    required this.title,
    required this.description,
    required this.dueDate,
  });

  @override
  List<Object?> get props => [title, description, dueDate];
}

extension CreateTaskParamsX on CreateTaskParams {
  CreateTaskParamsModel toData() => CreateTaskParamsModel(
        title: title,
        description: description,
        dueDate: dueDate,
        status: Status(id: 0, name: 'todo').toData(),
      );
}
