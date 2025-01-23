import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:task_management_test/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;
  RegisterUseCase({required AuthRepository repository})
      : _repository = repository;

  Future<Either<FirebaseException, User>> call(RegisterParams params) async {
    return await _repository.register(
        email: params.email, password: params.password);
  }
}

class RegisterParams {
  final String email;
  final String password;

  RegisterParams({required this.email, required this.password});
}
