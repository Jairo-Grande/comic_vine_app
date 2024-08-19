import 'package:comic_vine_app/domain/entities/app_config_entity.dart';
import 'package:yaml/yaml.dart';

class AppConfigModel extends AppConfig {
  /// @param baseUrl - The base URL that will be used in the request.
  /// @param connectTimeout - The maximum time the app will wait to connect to the server.
  /// @param receiveTimeout - The maximum time the app will wait to receive a response from the server.
  AppConfigModel({
    required super.baseUrl,
    required super.apiKey,
    required super.connectTimeOut,
    required super.receiveTimeOut,
  });

  factory AppConfigModel.fromMap(YamlMap json) => AppConfigModel(
      baseUrl: json["baseUrl"],
      apiKey: json["apiKey"],
      connectTimeOut: json["connectTimeOut"],
      receiveTimeOut: json["receiveTimeOut"]);
}
