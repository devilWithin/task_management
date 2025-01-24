import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:task_management_test/features/tasks/domain/entities/update_task_params.dart';
import 'package:task_management_test/features/tasks/domain/repositories/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository _repository;
  UpdateTaskUseCase({required TaskRepository repository})
      : _repository = repository;

  Future<Either<FirebaseException, Unit>> call(UpdateTaskParams params) async {
    return await _repository.updateTask(
      task: UpdateTaskParams(
        id: params.id,
        title: params.title,
        description: params.description,
        dueDate: params.dueDate,
      ),
    );
  }
}
