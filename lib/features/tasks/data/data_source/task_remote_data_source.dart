import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:task_management_test/features/tasks/data/models/create_task_params_model.dart';
import 'package:task_management_test/features/tasks/data/models/update_task_params_model.dart';

abstract class TaskRemoteDataSource {
  Future<Unit> createTask({required CreateTaskParamsModel task});

  Future<Unit> changeTaskStatus({required String id, required int status});

  Future<Unit> updateTask({required UpdateTaskParamsModel task});

  Future<void> deleteTask({required String id});
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final _fireStore = FirebaseFirestore.instance;

  @override
  Future<Unit> createTask({required CreateTaskParamsModel task}) async {
    try {
      final taskModelJson = task.toJson();
      await _fireStore
          .collection('tasks')
          .add(taskModelJson)
          .then((value) => value.update({'id': value.id}));
      return unit;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteTask({required String id}) async {
    try {
      return _fireStore.collection('tasks').doc(id).delete();
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Unit> updateTask({required UpdateTaskParamsModel task}) async {
    try {
      final taskModelJson = task.toJson();
      await _fireStore.collection('tasks').doc(task.id).update(taskModelJson);
      return unit;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Unit> changeTaskStatus(
      {required String id, required int status}) async {
    try {
      await _fireStore.collection('tasks').doc(id).update({'status': status});
      return unit;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }
}
