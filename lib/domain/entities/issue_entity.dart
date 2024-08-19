import 'package:comic_vine_app/data/model/issues_model.dart';

class Issues {
  String? error;
  int? limit;
  int? offset;
  int? numberOfPageResults;
  int? numberOfTotalResults;
  int? statusCode;
  String? issueNumber;
  List<ComicsModel>? results;
  String? version;

  Issues({
    required this.error,
    required this.limit,
    required this.issueNumber,
    required this.offset,
    required this.numberOfPageResults,
    required this.numberOfTotalResults,
    required this.statusCode,
    required this.results,
    required this.version,
  });

  factory Issues.fromJson(Map<String, dynamic> json) => Issues(
        issueNumber: json["issue_number"],
        error: json["error"],
        limit: json["limit"],
        offset: json["offset"],
        numberOfPageResults: json["number_of_page_results"],
        numberOfTotalResults: json["number_of_total_results"],
        statusCode: json["status_code"],
        results: List<ComicsModel>.from(
            json["results"].map((x) => ComicsModel.fromJson(x))),
        version: json["version"],
      );

  IssuesModel copyWith({
    String? error,
    int? limit,
    int? offset,
    String? issueNumber,
    int? numberOfPageResults,
    int? numberOfTotalResults,
    int? statusCode,
    List<ComicsModel>? results,
    String? version,
  }) {
    return IssuesModel(
      error: error ?? this.error,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      issueNumber: issueNumber ?? this.issueNumber,
      numberOfPageResults: numberOfPageResults ?? this.numberOfPageResults,
      numberOfTotalResults: numberOfTotalResults ?? this.numberOfTotalResults,
      statusCode: statusCode ?? this.statusCode,
      results: results ?? this.results,
      version: version ?? this.version,
    );
  }
}
