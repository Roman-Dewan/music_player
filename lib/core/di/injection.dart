import 'package:get_it/get_it.dart';
import 'package:flutter_app_template/core/network/dio_client.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core
  // Network
  sl.registerLazySingleton<DioClient>(() => DioClient());

  //! Features - Home
  // Data sources
  // sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(dioClient: sl()));
  
  // Repositories
  // sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(remoteDataSource: sl()));
  
  // Use cases
  // sl.registerLazySingleton(() => GetHomeDataUseCase(repository: sl()));
  
  // Blocs
  // sl.registerFactory(() => HomeBloc(getHomeDataUseCase: sl()));

  // Add more features below as your app grows
}
