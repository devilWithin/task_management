import 'package:flutter/material.dart';
import 'package:task_management_test/configs/routing/routes.dart';
import 'package:task_management_test/features/tasks/domain/entities/task_entity.dart';

class TaskItem extends StatelessWidget {
  final TaskEntity taskEntity;
  const TaskItem({super.key, required this.taskEntity});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      ///TODO -- CHANGE TILE COLOR BASED ON THE STATUS OF THE TASK
      ///
      leading: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(Routes.editTaskScreen, arguments: taskEntity);
        },
        child: Icon(Icons.edit),
      ),
      title: Text(taskEntity.title),
      subtitle: Text(taskEntity.description),
    );
  }
}
