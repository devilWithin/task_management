import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_test/core/base_state.dart';
import 'package:task_management_test/features/tasks/domain/entities/update_task_params.dart';
import 'package:task_management_test/features/tasks/domain/usecases/update_task_use_case.dart';

class UpdateTaskCubit extends Cubit<BaseState<Unit>> {
  final UpdateTaskUseCase _useCase;
  UpdateTaskCubit({required UpdateTaskUseCase useCase})
      : _useCase = useCase,
        super(const BaseState());

  Future<void> updateTask({required UpdateTaskParams params}) async {
    emit(state.setInProgressState());
    final result = await _useCase(params);
    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (item) => emit(state.setSuccessState(item)),
    );
  }
}
