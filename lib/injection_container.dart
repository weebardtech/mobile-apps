import 'package:get_it/get_it.dart';

import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'core/storage/auth_local_storage.dart';

final sl = GetIt.instance;

void init() {
  // AUTH FEATURE
  sl.registerLazySingleton(() => AuthRemoteDatasource());
  sl.registerLazySingleton(() => AuthLocalStorage());

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerFactory(() => AuthBloc(sl()));
}
