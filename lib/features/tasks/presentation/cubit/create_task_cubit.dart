import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_test/core/base_state.dart';
import 'package:task_management_test/features/tasks/domain/entities/create_task_params.dart';
import 'package:task_management_test/features/tasks/domain/entities/task_entity.dart';
import 'package:task_management_test/features/tasks/domain/usecases/create_task_use_case.dart';

class CreateTaskCubit extends Cubit<BaseState<TaskEntity>> {
  final CreateTaskUseCase _useCase;
  CreateTaskCubit({required CreateTaskUseCase useCase})
      : _useCase = useCase,
        super(const BaseState());

  Future<void> createTask({
    required CreateTaskParams task,
  }) async {
    emit(state.setInProgressState());
    final result = await _useCase(task);
    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (item) => emit(state.setSuccessState(item)),
    );
  }
}
