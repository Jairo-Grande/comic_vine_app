import 'package:comic_vine_app/data/failure.dart';
import 'package:comic_vine_app/domain/entities/comic_entity.dart';
import 'package:comic_vine_app/domain/entities/issue_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ComicVineRepository {
  Future<Either<Failure, Issues>> fetchIssues({int? offset});
  Future<Either<Failure, Comic>> fetchIssueById({int? id});
}
