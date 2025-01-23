import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management_test/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:task_management_test/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl({required AuthRemoteDataSource authRemoteDataSource})
      : _authRemoteDataSource = authRemoteDataSource;

  @override
  Future<Either<FirebaseAuthException, User>> login(
      {required String email, required String password}) async {
    try {
      final result = await _authRemoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthException(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<FirebaseAuthException, User>> register(
      {required String email, required String password}) async {
    try {
      final result = await _authRemoteDataSource.register(
        email: email,
        password: password,
      );
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthException(message: e.message, code: e.code));
    }
  }
}
