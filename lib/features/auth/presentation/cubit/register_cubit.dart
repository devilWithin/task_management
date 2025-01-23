import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_test/core/base_state.dart';
import 'package:task_management_test/features/auth/domain/usecases/register_use_case.dart';

class RegisterCubit extends Cubit<BaseState<User>> {
  final RegisterUseCase _useCase;
  RegisterCubit({required RegisterUseCase useCase})
      : _useCase = useCase,
        super(const BaseState());

  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(state.setInProgressState());
    final result =
        await _useCase(RegisterParams(email: email, password: password));
    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (item) => emit(state.setSuccessState(item)),
    );
  }
}
