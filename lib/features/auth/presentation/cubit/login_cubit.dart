import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management_test/core/widgets/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_test/features/auth/domain/usecases/login_use_case.dart';

class LoginCubit extends Cubit<BaseState<User>> {
  final LoginUseCase _useCase;

  LoginCubit({required LoginUseCase useCase})
      : _useCase = useCase,
        super(BaseState());

  Future<void> login({required String email, required String password}) async {
    emit(state.setInProgressState());
    final result =
        await _useCase(LoginParams(email: email, password: password));
    result.fold(
      (error) => emit(state.setFailureState(error)),
      (user) => emit(state.setSuccessState(user)),
    );
  }
}
