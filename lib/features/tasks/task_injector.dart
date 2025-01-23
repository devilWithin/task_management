import 'package:task_management_test/features/tasks/data/data_source/task_remote_data_source.dart';
import 'package:task_management_test/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:task_management_test/features/tasks/domain/repositories/task_repository.dart';
import 'package:task_management_test/features/tasks/domain/usecases/create_task_use_case.dart';
import 'package:task_management_test/features/tasks/domain/usecases/delete_task_use_case.dart';
import 'package:task_management_test/features/tasks/domain/usecases/update_task_use_case.dart';
import 'package:task_management_test/features/tasks/presentation/cubit/create_task_cubit.dart';
import 'package:task_management_test/features/tasks/presentation/cubit/delete_task_cubit.dart';
import 'package:task_management_test/features/tasks/presentation/cubit/update_task_cubit.dart';
import 'package:task_management_test/injection_container.dart';

void setupTaskInjector() {
  // Cubit
  sl.registerLazySingleton<CreateTaskCubit>(
    () => CreateTaskCubit(useCase: sl()),
  );
  sl.registerLazySingleton<UpdateTaskCubit>(
    () => UpdateTaskCubit(useCase: sl()),
  );
  sl.registerFactory<DeleteTaskCubit>(
    () => DeleteTaskCubit(useCase: sl()),
  );

  // UseCase
  sl.registerLazySingleton<CreateTaskUseCase>(
    () => CreateTaskUseCase(repository: sl()),
  );

  sl.registerLazySingleton<UpdateTaskUseCase>(
    () => UpdateTaskUseCase(repository: sl()),
  );

  sl.registerLazySingleton<DeleteTaskUseCase>(
    () => DeleteTaskUseCase(repository: sl()),
  );

  // Repository
  sl.registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(remoteDataSource: sl()));

  // DataSource
  sl.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(),
  );
}
