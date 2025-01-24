import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:task_management_test/features/tasks/domain/repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository _repository;
  DeleteTaskUseCase({required TaskRepository repository})
      : _repository = repository;

  Future<Either<FirebaseException, Unit>> call(String params) async {
    return await _repository.deleteTask(id: params);
  }
}
