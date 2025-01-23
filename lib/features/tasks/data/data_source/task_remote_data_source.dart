import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management_test/features/tasks/data/models/create_task_params_model.dart';
import 'package:task_management_test/features/tasks/data/models/task_model.dart';
import 'package:task_management_test/features/tasks/data/models/update_task_params_model.dart';

abstract class TaskRemoteDataSource {
  Future<TaskModel> createTask({required CreateTaskParamsModel task});

  Future<TaskModel> updateTask({required UpdateTaskParamsModel task});

  Future<void> deleteTask({required String id});
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final _fireStore = FirebaseFirestore.instance;

  @override
  Future<TaskModel> createTask({required CreateTaskParamsModel task}) {
    // TODO: implement createTask
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTask({required String id}) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<TaskModel> updateTask({required UpdateTaskParamsModel task}) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
