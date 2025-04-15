import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tatto_app_mobile/features/tattoo_generator/data/datasources/tattoo_remote_data_source.dart';
import 'package:tatto_app_mobile/features/tattoo_generator/data/repositories/tattoo_repository_impl.dart';
import 'package:tatto_app_mobile/features/tattoo_generator/domain/repositories/tattoo_repository.dart';
import 'package:tatto_app_mobile/features/tattoo_generator/domain/usecases/generate_tattoo.dart';
import 'package:tatto_app_mobile/features/tattoo_generator/domain/usecases/save_tattoo_to_gallery.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Use cases
  sl.registerLazySingleton(() => GenerateTattoo(sl()));
  sl.registerLazySingleton(() => SaveTattooToGallery(sl()));

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
