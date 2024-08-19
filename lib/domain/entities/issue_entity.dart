import 'package:comic_vine_app/data/model/issues_model.dart';

class Issues {
 final String? error;
 final int? limit;
 final int? offset;
 final int? numberOfPageResults;
 final int? numberOfTotalResults;
 final int? statusCode;
 final String? issueNumber;
 final List<ComicsModel>? results;
 final String? version;

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
}
