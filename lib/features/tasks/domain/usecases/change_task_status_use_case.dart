import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:task_management_test/features/tasks/domain/repositories/task_repository.dart';

class ChangeTaskStatusUseCase {
  final TaskRepository _repository;
  ChangeTaskStatusUseCase({required TaskRepository repository})
      : _repository = repository;

  Future<Either<FirebaseException, Unit>> call(
      ChangeTaskStatusParams params) async {
    return await _repository.changeTaskStatus(
      id: params.id,
      status: params.status,
    );
  }
}

class ChangeTaskStatusParams {
  final String id;
  final int status;
  ChangeTaskStatusParams({required this.id, required this.status});
}
