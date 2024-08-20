import 'package:comic_vine_app/data/failure.dart';
import 'package:comic_vine_app/data/model/issues_model.dart';
import 'package:comic_vine_app/domain/entities/comic_entity.dart';

import 'package:comic_vine_app/domain/repositories/comic_vine_local_repository.dart';

import 'package:dartz/dartz.dart';

class GetComicVineLocal {
  final ComicVineLocalRepository repository;

  GetComicVineLocal(this.repository);

  Future<Either<Failure, int>> insertIssue({required ComicsModel comic}) {
    return repository.insertIssue(comic: comic);
  }

  Future<Either<Failure, Comic>> getIssueById({required int id}) {
    return repository.getIssueById(id: id);
  }

  Future<Either<Failure, int>> updateComic({required ComicsModel comic}) {
    return repository.updateComic(comic: comic);
  }

  Future<Either<Failure, int>> deleteComic({required int id}) {
    return repository.deleteComic(id: id);
  }
}
