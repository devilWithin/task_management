import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<FirebaseAuthException, User>> login(
      {required String email, required String password});
  Future<Either<FirebaseAuthException, User>> register(
      {required String email, required String password});
}
