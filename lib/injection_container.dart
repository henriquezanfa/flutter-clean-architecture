import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'features/number_trivia/domain/repositories/trivia_repository.dart';
import 'features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final inject = GetIt.instance;

Future<void> init() async {
  // features
  inject.registerFactory(
    () => NumberTriviaBloc(
      concrete: inject(),
      inputConverter: inject(),
      random: inject(),
    ),
  );

  inject.registerLazySingleton(() => GetConcreteNumberTrivia(inject()));
  inject.registerLazySingleton(() => GetRandomNumberTrivia(inject()));

  inject.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      localDataSource: inject(),
      networkInfo: inject(),
      remoteDataSource: inject(),
    ),
  );

  inject.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(client: inject()),
  );

  inject.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(sharedPreferences: inject()),
  );

  // core
  inject.registerLazySingleton(() => InputConverter());
  inject.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(inject()));

  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  inject.registerLazySingleton(() => sharedPreferences);
  inject.registerLazySingleton(() => http.Client());
  inject.registerLazySingleton(() => DataConnectionChecker());
}
