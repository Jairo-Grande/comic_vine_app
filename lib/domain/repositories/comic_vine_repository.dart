import 'package:comic_vine_app/data/failure.dart';
import 'package:comic_vine_app/data/model/issues_model.dart';
import 'package:dartz/dartz.dart';

abstract class ComicVineRepository {
  Future<Either<Failure, IssuesModel>> fetchIssues({int? offset});
  Future<Either<Failure, ComicsModel>> fetchIssueById({int? id});
}
