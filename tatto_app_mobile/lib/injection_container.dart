import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'features/tattoo_generator/data/datasources/tattoo_remote_data_source.dart';
import 'features/tattoo_generator/data/repositories/tattoo_repository_impl.dart';
import 'features/tattoo_generator/domain/repositories/tattoo_repository.dart';
import 'features/tattoo_generator/domain/usecases/generate_tattoo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Use cases
  sl.registerLazySingleton(() => GenerateTattoo(sl()));

  // External
  sl.registerLazySingleton(() => Dio());

  // Data sources
  sl.registerLazySingleton<TattooRemoteDataSource>(
    () => TattooRemoteDataSourceImpl(dio: sl()),
  );

  // Repository
  sl.registerLazySingleton<TattooRepository>(
    () => TattooRepositoryImpl(remoteDataSource: sl()),
  );
}
