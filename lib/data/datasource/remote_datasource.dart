import 'package:comic_vine_app/data/exeption.dart';
import 'package:comic_vine_app/data/model/issues_model.dart';
import 'package:dio/dio.dart';

class RemoteDataSource {
  late BaseOptions _optionsApi;
  late Dio _client;

  RemoteDataSource({
    required String baseUrl,
    required String apiKey,
    required int connectTimeout,
    required int receiveTimeout,
  }) {
    _optionsApi = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.json,
      queryParameters: {'api_key': apiKey, 'format': 'json'},
      headers: {'Content-Type': 'application/json'},
      connectTimeout: Duration(seconds: connectTimeout),
      receiveTimeout: Duration(seconds: receiveTimeout),
    );

    _client = Dio(_optionsApi);
    _configureInterceptors();
  }

  void _configureInterceptors() {
    addInterceptor(InterceptorsWrapper(
      onRequest: (options, handler) {
        handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);        
      },
      onError: (error, handler) {
        handler.next(error);
      },
    ));
  }

  void addInterceptor(Interceptor interceptor) {
    _client.interceptors.add(interceptor);
  }

  Future<IssuesModel> fetchIssues({int? offset}) async {
    final Map<String, dynamic> queryParams = {
      'offset': offset ?? 0,
      'sort': 'date_added:desc',
      'limit': 10,
      'field_list': 'id,name,store_date,volume,image,issue_number',
    };

    final apiResponse = await _client
        .get('/issues', queryParameters: queryParams)
        .catchError((error) {
      return error.response;
    });

    if (apiResponse.statusCode == 200) {
      try {
        return IssuesModel.fromJson((apiResponse.data));
      } catch (error) {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }

  Future<IssuesModel> fetchIssueById({int? id}) async {
    final Map<String, dynamic> queryParams = {
      'field_list':
          'person_credits,character_credits,team_credits,location_credits,concept_credits',
    };

    final apiResponse = await _client
        .get('/issue/4000-$id/', queryParameters: queryParams)
        .catchError((error) {
      return error.response;
    });

    if (apiResponse.statusCode == 200) {
      try {
        final issues = IssuesModel.fromJson((apiResponse.data));
        return issues;
      } catch (error) {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }
}
