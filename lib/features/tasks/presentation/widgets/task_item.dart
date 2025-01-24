import 'package:flutter/material.dart';
import 'package:task_management_test/configs/routing/routes.dart';
import 'package:task_management_test/features/tasks/domain/entities/task_entity.dart';

class TaskItem extends StatelessWidget {
  final TaskEntity taskEntity;
  const TaskItem({super.key, required this.taskEntity});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: taskEntity.status.id == 0
          ? Colors.orange
          : taskEntity.status.id == 1
              ? Colors.white
              : Colors.green,
      leading: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(Routes.editTaskScreen, arguments: taskEntity);
        },
        child: Icon(Icons.edit),
      ),
      title: Text(taskEntity.title),
      trailing: InkWell(
        onTap: () {
          // delete task
        },
        child: Icon(Icons.delete),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(taskEntity.description),
          Text(taskEntity.dueDate.toString()),
        ],
      ),
    );
  }
}
