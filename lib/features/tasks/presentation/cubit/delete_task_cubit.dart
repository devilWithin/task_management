import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_test/core/widgets/base_state.dart';
import 'package:task_management_test/features/tasks/domain/usecases/delete_task_use_case.dart';

class DeleteTaskCubit extends Cubit<BaseState<Unit>> {
  final DeleteTaskUseCase _useCase;
  DeleteTaskCubit({required DeleteTaskUseCase useCase})
      : _useCase = useCase,
        super(const BaseState());

  Future<void> deleteTask({required String id}) async {
    emit(state.setInProgressState());
    final result = await _useCase(id);
    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (item) => emit(state.setSuccessState(item)),
    );
  }
}
