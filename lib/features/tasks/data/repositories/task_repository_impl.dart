import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:task_management_test/features/tasks/data/data_source/task_remote_data_source.dart';
import 'package:task_management_test/features/tasks/data/models/task_model.dart';
import 'package:task_management_test/features/tasks/domain/entities/create_task_params.dart';
import 'package:task_management_test/features/tasks/domain/entities/task_entity.dart';
import 'package:task_management_test/features/tasks/domain/entities/update_task_params.dart';
import 'package:task_management_test/features/tasks/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource _remoteDataSource;

  TaskRepositoryImpl({required TaskRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<FirebaseException, TaskEntity>> createTask({
    required CreateTaskParams task,
  }) async {
    try {
      final taskEntity =
          await _remoteDataSource.createTask(task: task.toData());
      return Right(taskEntity.toDomain());
    } on FirebaseException catch (e) {
      return Left(FirebaseException(
          message: e.message, code: e.code, plugin: 'create task'));
    }
  }

  @override
  Future<Either<FirebaseException, Unit>> deleteTask({required int id}) async {
    try {
      await _remoteDataSource.deleteTask(id: id.toString());
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(FirebaseException(
          message: e.message, code: e.code, plugin: 'delete task'));
    }
  }

  @override
  Future<Either<FirebaseException, Unit>> updateTask(
      {required UpdateTaskParams task}) async {
    try {
      await _remoteDataSource.updateTask(task: task.toData());
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(FirebaseException(
          message: e.message, code: e.code, plugin: 'update task'));
    }
  }
}
