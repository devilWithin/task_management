import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_test/core/widgets/base_state.dart';
import 'package:task_management_test/features/tasks/domain/usecases/change_task_status_use_case.dart';

class ChangeTaskStatusCubit extends Cubit<BaseState<Unit>> {
  final ChangeTaskStatusUseCase _useCase;
  ChangeTaskStatusCubit({required ChangeTaskStatusUseCase useCase})
      : _useCase = useCase,
        super(const BaseState());

  Future<void> changeTaskStatus(
      {required ChangeTaskStatusParams params}) async {
    emit(state.setInProgressState());
    final result = await _useCase(params);
    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (item) => emit(state.setSuccessState(item)),
    );
  }
}
