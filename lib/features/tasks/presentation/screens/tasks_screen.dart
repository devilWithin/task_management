import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_management_test/configs/routing/routes.dart';
import 'package:task_management_test/core/widgets/widgets.dart';
import 'package:task_management_test/features/tasks/data/models/task_model.dart';
import 'package:task_management_test/features/tasks/presentation/widgets/task_item.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final tasksStream = FirebaseFirestore.instance
      .collection('tasks')
      .orderBy('due_date')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithTitle(
      bottomWidget: BottomAppBar(
        child: CustomElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.createTaskScreen);
          },
          title: 'Add',
        ),
      ),
      title: 'Tasks',
      body: StreamBuilder<QuerySnapshot>(
          stream: tasksStream,
          builder: (context, snapshot) {
            List<TaskItem> tasksList = [];
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.active) {
              final tasks = snapshot.data!.docs.reversed;
              for (var task in tasks) {
                final taskModel =
                    TaskModel.fromJson(task.data() as Map<String, dynamic>);
                final taskEntity = taskModel.toDomain();
                final taskItem = TaskItem(
                  taskEntity: taskEntity,
                );
                tasksList.add(taskItem);
              }
              return ListView(
                children: tasksList,
              );
            }
            return const Center(
              child: Text('No tasks found'),
            );
          }),
    );
  }
}
