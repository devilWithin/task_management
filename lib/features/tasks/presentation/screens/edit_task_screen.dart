import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_management_test/core/widgets/base_state.dart';
import 'package:task_management_test/core/utils/string_validator.dart';
import 'package:task_management_test/core/widgets/widgets.dart';
import 'package:task_management_test/features/tasks/domain/entities/task_entity.dart';
import 'package:task_management_test/features/tasks/domain/entities/update_task_params.dart';
import 'package:task_management_test/features/tasks/presentation/cubit/update_task_cubit.dart';
import 'package:task_management_test/injection_container.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskEntity taskEntity;
  const EditTaskScreen({super.key, required this.taskEntity});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _updateTaskCubit = sl<UpdateTaskCubit>();
  late String dueData;
  DateTime? selectedDate;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.taskEntity.title;
    _descriptionController.text = widget.taskEntity.description;
    dueData = widget.taskEntity.dueDate.toString();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithTitle(
      title: 'Edit Task',
      body: Form(
        key: _formKey,
        child: Column(
          spacing: 16,
          children: [
            CustomTextFormField(
              controller: _titleController,
              validationType: ValidationType.nameEn,
              hint: 'Title',
              label: 'Enter the title',
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Title is required';
              //   }
              //   if (_titleController.text.contains(widget.taskEntity.title)) {
              //     return 'Title is same as previous';
              //   }
              //   return null;
              // },
            ),
            CustomTextFormField(
              controller: _descriptionController,
              validationType: ValidationType.nameEn,
              hint: 'Description',
              label: 'Enter the description',
            ),
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: Text(dueData),
                ),
                IconButton(
                  onPressed: () async {
                    selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        dueData = DateFormat('yMMMd').format(selectedDate!);
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                ),
              ],
            ),
            BlocConsumer<UpdateTaskCubit, BaseState<void>>(
              bloc: _updateTaskCubit,
              listenWhen: (previous, current) => previous != current,
              listener: (context, state) {
                if (state.isFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to update task')),
                  );
                } else if (state.isSuccess) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state.isInProgress) {
                  return const CircularProgressIndicator();
                }
                return CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _updateTaskCubit.updateTask(
                        params: UpdateTaskParams(
                          id: widget.taskEntity.id,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          dueDate: selectedDate,
                        ),
                      );
                    }
                  },
                  title: 'Update',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
