import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:task_management_test/features/tasks/domain/entities/create_task_params.dart';
import 'package:task_management_test/features/tasks/domain/entities/task_entity.dart';
import 'package:task_management_test/features/tasks/domain/repositories/task_repository.dart';

class CreateTaskUseCase {
  final TaskRepository _repository;
  CreateTaskUseCase({required TaskRepository repository})
      : _repository = repository;

  Future<Either<FirebaseException, Unit>> call(CreateTaskParams params) async {
    return await _repository.createTask(task: params);
  }
}
