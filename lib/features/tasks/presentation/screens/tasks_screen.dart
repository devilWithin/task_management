import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_management_test/configs/routing/routes.dart';
import 'package:task_management_test/core/widgets/custom_elevated_button.dart';
import 'package:task_management_test/features/tasks/domain/entities/task_entity.dart';
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
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: CustomElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.createTaskScreen);
          },
          title: 'Add',
        ),
      ),
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: tasksStream,
          builder: (context, snapshot) {
            List<TaskItem> tasksList = [];
            final tasks = snapshot.data!.docs.reversed;
            for (var task in tasks) {
              final title = task.get('title');
              final description = task.get('description');
              final status = task.get('status');
              final dueDate = task.get('due_date');
              final id = task.get('id');
              final taskItem = TaskItem(
                  taskEntity: TaskEntity(
                id: id,
                title: title,
                description: description,
                status: status,
                dueDate: dueDate,
              ));
              tasksList.add(taskItem);
            }
            return ListView(
              reverse: true,
              children: tasksList,
            );
          }),
    );
  }
}
