import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:task_management_test/features/auth/auth_injector.dart';
import 'package:task_management_test/features/tasks/task_injector.dart';

final sl = GetIt.instance;

void init() {
  setupAuthInjector();
  setupTaskInjector();

  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
}
