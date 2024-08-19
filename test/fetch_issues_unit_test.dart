import 'package:comic_vine_app/data/datasource/remote_datasource.dart';
import 'package:comic_vine_app/data/failure.dart';
import 'package:comic_vine_app/data/model/app_config_model.dart';
import 'package:comic_vine_app/domain/entities/app_config_entity.dart';
import 'package:comic_vine_app/domain/entities/comic_entity.dart';
import 'package:comic_vine_app/domain/entities/issue_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:comic_vine_app/data/reposities/comic_vine_repository_impl.dart';

import 'package:dartz/dartz.dart';

import 'package:yaml/yaml.dart';

import 'fetch_issues_unit_test.mocks.dart';

// Genera el mock de Dio
@GenerateMocks([Dio])
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  late MockDio mockDio;
  late ComicVineRepositoryImpl comicVineApiRepositoryImpl;

//read app_config to obtain API_key and EndPoint to be tested.
  final configFile = await rootBundle.loadString('lib/config/app_config.yaml');
  final YamlMap yamlMap = loadYaml(configFile);
  late AppConfig appConfig = AppConfigModel.fromMap(yamlMap);

  setUp(() {
    mockDio = MockDio();
  });

  group('fetchIssues', () {
    test('successfull Issues returned', () async {
      comicVineApiRepositoryImpl = ComicVineRepositoryImpl(
          remoteDatasource: RemoteDataSource(
              apiKey: appConfig.apiKey,
              baseUrl: appConfig.baseUrl,
              connectTimeout: appConfig.connectTimeOut,
              receiveTimeout: appConfig.receiveTimeOut));

      // Simula la respuesta de la API
      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => Response(
                  requestOptions: RequestOptions(path: 'issues'),
                  statusCode: 200,
                  data: {
                    "error": "OK",
                    "limit": 1,
                    "offset": 0,
                    "number_of_page_results": 1,
                    "number_of_total_results": 1014122,
                    "status_code": 1,
                    "results": [
                      {
                        "aliases": null,
                        "api_detail_url":
                            "https://comicvine.gamespot.com/api/issue/4000-6/",
                        "cover_date": "1952-10-01",
                        "date_added": "2008-06-06 11:10:16",
                        "date_last_updated": "2022-07-11 23:51:22",
                        "deck": null,
                        "description":
                            "<p>The horrors of:</p><p>- Lost race!</p><p>- The man germ!</p><p>- Man in the hood!</p><p>- The things!</p><p>-Stories behind the stars, featuring the legendary battle between Hercules, Hydra and Iolaus!</p><p>Plus, two page long prose-stories.</p>",
                        "has_staff_review": false,
                        "id": 6,
                        "image": {
                          "icon_url":
                              "https://comicvine.gamespot.com/a/uploads/square_avatar/5/58993/2645776-chamber_of_chills__13_cgc_8.5.jpg",
                          "medium_url":
                              "https://comicvine.gamespot.com/a/uploads/scale_medium/5/58993/2645776-chamber_of_chills__13_cgc_8.5.jpg",
                          "screen_url":
                              "https://comicvine.gamespot.com/a/uploads/screen_medium/5/58993/2645776-chamber_of_chills__13_cgc_8.5.jpg",
                          "screen_large_url":
                              "https://comicvine.gamespot.com/a/uploads/screen_kubrick/5/58993/2645776-chamber_of_chills__13_cgc_8.5.jpg",
                          "small_url":
                              "https://comicvine.gamespot.com/a/uploads/scale_small/5/58993/2645776-chamber_of_chills__13_cgc_8.5.jpg",
                          "super_url":
                              "https://comicvine.gamespot.com/a/uploads/scale_large/5/58993/2645776-chamber_of_chills__13_cgc_8.5.jpg",
                          "thumb_url":
                              "https://comicvine.gamespot.com/a/uploads/scale_avatar/5/58993/2645776-chamber_of_chills__13_cgc_8.5.jpg",
                          "tiny_url":
                              "https://comicvine.gamespot.com/a/uploads/square_mini/5/58993/2645776-chamber_of_chills__13_cgc_8.5.jpg",
                          "original_url":
                              "https://comicvine.gamespot.com/a/uploads/original/5/58993/2645776-chamber_of_chills__13_cgc_8.5.jpg",
                          "image_tags": "All Images"
                        },
                        "associated_images": [
                          {
                            "original_url":
                                "https://comicvine.gamespot.com/a/uploads/original/0/4/7-1487-6-1-chamber-of-chills.jpg",
                            "id": 7,
                            "caption": null,
                            "image_tags": "All Images"
                          }
                        ],
                        "issue_number": "13",
                        "name": "The Lost Race",
                        "site_detail_url":
                            "https://comicvine.gamespot.com/chamber-of-chills-magazine-13-the-lost-race/4000-6/",
                        "store_date": null,
                        "volume": {
                          "api_detail_url":
                              "https://comicvine.gamespot.com/api/volume/4050-1487/",
                          "id": 1487,
                          "name": "Chamber of Chills Magazine",
                          "site_detail_url":
                              "https://comicvine.gamespot.com/chamber-of-chills-magazine/4050-1487/"
                        }
                      }
                    ],
                    "version": "1.0"
                  }));

      // Verifica que la respuesta sea un Issues
      expect(await comicVineApiRepositoryImpl.fetchIssues(),
          isA<Right<Failure, Issues>>());
    });

    test('Failure fetching Issues', () async {
      comicVineApiRepositoryImpl = ComicVineRepositoryImpl(
          remoteDatasource: RemoteDataSource(
              apiKey: "f5d54aa1c721b15748302ecdfaa143a21201599a",
              baseUrl: "https://comicvine.gamespot.com/api/Test",
              connectTimeout: 120000,
              receiveTimeout: 120000));

      // Simula la respuesta de la API
      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => Response(
                  requestOptions: RequestOptions(path: 'issues'),
                  statusCode: 404,
                  data: {
                    "error": "Error in URL Format",
                    "limit": 0,
                    "offset": 0,
                    "number_of_page_results": 0,
                    "number_of_total_results": 0,
                    "status_code": 102,
                    "results": []
                  }));

      // Verifica que la respuesta sea un Either con Issues
      expect(await comicVineApiRepositoryImpl.fetchIssues(),
          isA<Left<Failure, Issues>>());
    });

    test('successfull IssueDetails returned', () async {
      comicVineApiRepositoryImpl = ComicVineRepositoryImpl(
          remoteDatasource: RemoteDataSource(
              apiKey: appConfig.apiKey,
              baseUrl: appConfig.baseUrl,
              connectTimeout: appConfig.connectTimeOut,
              receiveTimeout: appConfig.receiveTimeOut));

      // Simula la respuesta de la API
      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => Response(
                  requestOptions: RequestOptions(path: 'issue/4000-1067091/'),
                  statusCode: 200,
                  data: {
                    "error": "OK",
                    "limit": 1,
                    "offset": 0,
                    "number_of_page_results": 1,
                    "number_of_total_results": 1,
                    "status_code": 1,
                    "results": {
                      "character_credits": [
                        {
                          "api_detail_url":
                              "https://comicvine.gamespot.com/api/character/4005-41447/",
                          "id": 41447,
                          "name": "Lum",
                          "site_detail_url":
                              "https://comicvine.gamespot.com/lum/4005-41447/"
                        }
                      ],
                      "concept_credits": [],
                      "location_credits": [],
                      "person_credits": [
                        {
                          "api_detail_url":
                              "https://comicvine.gamespot.com/api/person/4040-84714/",
                          "id": 84714,
                          "name": "Andrea Accardi",
                          "site_detail_url":
                              "https://comicvine.gamespot.com/andrea-accardi/4040-84714/",
                          "role": "editor"
                        }
                      ],
                      "team_credits": []
                    },
                    "version": "1.0"
                  }));

      // Verifica que la respuesta sea un Issues
      expect(await comicVineApiRepositoryImpl.fetchIssueById(id: 1067091),
          isA<Right<Failure, Comic>>());
    });

    test('Failure fetching Issue Details', () async {
      comicVineApiRepositoryImpl = ComicVineRepositoryImpl(
          remoteDatasource: RemoteDataSource(
              apiKey: "f5d54aa1c721b15748302ecdfaa143a21201599a",
              baseUrl: "https://comicvine.gamespot.com/api/issue/4000-1067091/",
              connectTimeout: 120000,
              receiveTimeout: 120000));

      // Simula la respuesta de la API
      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => Response(
                  requestOptions: RequestOptions(path: 'issue/4000-1067091/'),
                  statusCode: 401,
                  data: {
                    "error": "Invalid API Key",
                    "limit": 0,
                    "offset": 0,
                    "number_of_page_results": 0,
                    "number_of_total_results": 0,
                    "status_code": 100,
                    "results": []
                  }));

      expect(await comicVineApiRepositoryImpl.fetchIssueById(id: 1067091),
          isA<Left<Failure, Comic>>());
    });
  });
}
