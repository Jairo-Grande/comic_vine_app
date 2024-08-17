import 'package:comic_vine_app/data/model/issues_model.dart';

class Issue {
    String? error;
    int? limit;
    int? offset;
    int? numberOfPageResults;
    int? numberOfTotalResults;
    int? statusCode;
    List<ComicsModel>? results;
    String? version;

    Issue({
        required this.error,
        required this.limit,
        required this.offset,
        required this.numberOfPageResults,
        required this.numberOfTotalResults,
        required this.statusCode,
        required this.results,
        required this.version,
    });

    factory Issue.fromJson(Map<String, dynamic> json) => Issue(
        error: json["error"],
        limit: json["limit"],
        offset: json["offset"],
        numberOfPageResults: json["number_of_page_results"],
        numberOfTotalResults: json["number_of_total_results"],
        statusCode: json["status_code"],
        results: List<ComicsModel>.from(json["results"].map((x) => ComicsModel.fromJson(x))),
        version: json["version"],
    );

   
}