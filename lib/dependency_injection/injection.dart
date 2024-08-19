import 'package:comic_vine_app/data/datasource/remote_datasource.dart';
import 'package:comic_vine_app/data/model/app_config_model.dart';
import 'package:comic_vine_app/data/reposities/comic_vine_repository_impl.dart';
import 'package:comic_vine_app/domain/entities/app_config_entity.dart';
import 'package:comic_vine_app/domain/repositories/comic_vine_repository.dart';
import 'package:comic_vine_app/domain/use_cases/get_comic_vine_api.dart';
import 'package:comic_vine_app/ui/features/comics/bloc/comics_bloc.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:yaml/yaml.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //Configuration
  final configFile = await rootBundle.loadString('lib/config/app_config.yaml');
  final YamlMap yamlMap = loadYaml(configFile);
  late AppConfig appConfig = AppConfigModel.fromMap(yamlMap);

  // bloc
  locator.registerFactory(() => IssueBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetComicVineApi(locator()));

  // repository
  locator.registerLazySingleton<ComicVineRepository>(
    () => ComicVineRepositoryImpl(
      remoteDatasource: locator(),
    ),
  );

  



  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource(
      baseUrl: appConfig.baseUrl,
      connectTimeout: appConfig.connectTimeOut,
      receiveTimeout: appConfig.receiveTimeOut,
  
      apiKey: appConfig.apiKey));

  // external

}
