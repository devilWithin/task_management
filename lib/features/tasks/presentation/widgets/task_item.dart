import 'package:flutter/material.dart';
import 'package:task_management_test/configs/routing/routes.dart';
import 'package:task_management_test/core/utils/notifications.dart';
import 'package:task_management_test/features/tasks/domain/entities/task_entity.dart';
import 'package:task_management_test/features/tasks/domain/usecases/change_task_status_use_case.dart';
import 'package:task_management_test/features/tasks/presentation/cubit/change_task_status_cubit.dart';
import 'package:task_management_test/features/tasks/presentation/cubit/delete_task_cubit.dart';
import 'package:task_management_test/injection_container.dart';

class TaskItem extends StatefulWidget {
  final TaskEntity taskEntity;
  const TaskItem({super.key, required this.taskEntity});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  final _changeTaskStatusCubit = sl<ChangeTaskStatusCubit>();
  final _deleteTaskCubit = sl<DeleteTaskCubit>();
  INotificationService localNotificationService = LocalNotificationService();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      LocalNotificationService().scheduleNotification(
        title: widget.taskEntity.title,
        scheduledDate: widget.taskEntity.dueDate,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onLongPress: () {
          int newStatus = widget.taskEntity.status;
          switch (widget.taskEntity.status) {
            case 0:
              newStatus = 1;
              break;
            case 1:
              newStatus = 2;
              break;
            case 2:
              newStatus = 0;
              break;
          }
          _changeTaskStatusCubit.changeTaskStatus(
            params: ChangeTaskStatusParams(
              id: widget.taskEntity.id,
              status: newStatus,
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tileColor: widget.taskEntity.status == 0
            ? Colors.orange
            : widget.taskEntity.status == 1
                ? Colors.white
                : Colors.green,
        leading: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(Routes.editTaskScreen, arguments: widget.taskEntity);
          },
          child: Icon(Icons.edit),
        ),
        title: Text(widget.taskEntity.title),
        trailing: InkWell(
          onTap: () {
            _deleteTaskCubit.deleteTask(id: widget.taskEntity.id);
          },
          child: Icon(Icons.delete),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text('Desc: ${widget.taskEntity.description}'),
            Text('Due date: ${widget.taskEntity.dueDate.toString()}'),
            Text(
                'Status: ${widget.taskEntity.status == 0 ? 'ToDo' : widget.taskEntity.status == 1 ? 'In Progress' : 'Completed'}'),
          ],
        ),
      ),
    );
  }
}
