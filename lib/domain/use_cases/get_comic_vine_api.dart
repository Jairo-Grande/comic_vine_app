import 'package:comic_vine_app/data/failure.dart';
import 'package:comic_vine_app/domain/entities/comic_entity.dart';
import 'package:comic_vine_app/domain/entities/issue_entity.dart';
import 'package:comic_vine_app/domain/repositories/comic_vine_repository.dart';
import 'package:dartz/dartz.dart';

class GetComicVineApi {
  final ComicVineRepository repository;

  GetComicVineApi(this.repository);

  Future<Either<Failure, Issues>> getIssues(
      {int? offset, String? name, String? dateDescriptor}) {
    return repository.fetchIssues(offset: offset);
  }

  Future<Either<Failure, Comic>> getIssueById({required int id}) {
    return repository.fetchIssueById(id:id);
  }
}
