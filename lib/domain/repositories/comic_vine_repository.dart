import 'package:comic_vine_app/data/failure.dart';
import 'package:comic_vine_app/data/model/issues_model.dart';

import 'package:comic_vine_app/domain/entities/issue_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ComicVineRepository {
  Future<Either<Failure, Issues>> fetchIssues({int? offset});
  Future<Either<Failure, ComicsModel>> fetchIssueById({int? id});
}
