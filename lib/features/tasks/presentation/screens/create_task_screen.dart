import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_management_test/core/widgets/base_state.dart';
import 'package:task_management_test/core/utils/string_validator.dart';
import 'package:task_management_test/core/widgets/widgets.dart';
import 'package:task_management_test/features/tasks/domain/entities/create_task_params.dart';
import 'package:task_management_test/features/tasks/presentation/cubit/create_task_cubit.dart';
import 'package:task_management_test/injection_container.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? dueData;
  DateTime? selectedDate;
  final _createTaskCubit = sl<CreateTaskCubit>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithTitle(
      title: 'Add Task',
      body: Column(
        spacing: 16,
        children: [
          CustomTextFormField(
            controller: _titleController,
            validationType: ValidationType.nameEn,
            hint: 'Title',
            label: 'Enter the title',
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
                child: Text(dueData ?? 'Select Due Date'),
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
                      selectedDate = DateTime(
                        selectedDate!.year,
                        selectedDate!.month,
                        selectedDate!.day,
                        DateTime.now().hour,
                        DateTime.now().minute + 32,
                      );
                    });
                  }
                },
                icon: const Icon(Icons.calendar_today),
              ),
            ],
          ),
          BlocConsumer<CreateTaskCubit, BaseState<void>>(
            bloc: _createTaskCubit,
            listenWhen: (previous, current) => previous != current,
            listener: (context, state) {
              if (state.isFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.failure!.message!),
                  ),
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
                onPressed: () async {
                  if (_titleController.text.isNotEmpty &&
                      _descriptionController.text.isNotEmpty &&
                      dueData != null) {
                    await _createTaskCubit.createTask(
                      task: CreateTaskParams(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        dueDate: selectedDate!,
                      ),
                    );
                  }
                },
                title: 'Add',
              );
            },
          ),
        ],
      ),
    );
  }
}
