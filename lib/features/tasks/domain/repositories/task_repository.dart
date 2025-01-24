import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:task_management_test/features/tasks/domain/entities/create_task_params.dart';
import 'package:task_management_test/features/tasks/domain/entities/task_entity.dart';
import 'package:task_management_test/features/tasks/domain/entities/update_task_params.dart';

abstract class TaskRepository {
  Future<Either<FirebaseException, Unit>> createTask(
      {required CreateTaskParams task});

  Future<Either<FirebaseException, Unit>> changeTaskStatus(
      {required String id, required int status});

  Future<Either<FirebaseException, Unit>> updateTask(
      {required UpdateTaskParams task});

  Future<Either<FirebaseException, Unit>> deleteTask({required String id});
}
