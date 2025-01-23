import 'package:task_management_test/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:task_management_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:task_management_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:task_management_test/features/auth/domain/usecases/login_use_case.dart';
import 'package:task_management_test/features/auth/domain/usecases/register_use_case.dart';
import 'package:task_management_test/features/auth/presentation/cubit/login_cubit.dart';
import 'package:task_management_test/features/auth/presentation/cubit/register_cubit.dart';
import 'package:task_management_test/injection_container.dart';

void setupAuthInjector() {
  // Cubit
  sl.registerLazySingleton<LoginCubit>(() => LoginCubit(useCase: sl()));
  sl.registerLazySingleton<RegisterCubit>(() => RegisterCubit(useCase: sl()));

  // UseCase
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: sl()));

  // Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(firebaseAuth: sl()));
}
