import 'package:comic_vine_app/data/datasource/local_datasource.dart';
import 'package:comic_vine_app/data/exeption.dart';

import 'package:comic_vine_app/data/failure.dart';
import 'package:comic_vine_app/data/model/issues_model.dart';
import 'package:comic_vine_app/domain/entities/comic_entity.dart';

import 'package:comic_vine_app/domain/repositories/comic_vine_local_repository.dart';
import 'package:dartz/dartz.dart';

class ComicVineLocalRepositoryImpl implements ComicVineLocalRepository {
  final LocalDatasource localDatasource;
  ComicVineLocalRepositoryImpl({required this.localDatasource});

  @override
  Future<Either<Failure, ComicsModel>> getIssueById({required int id}) async {
    try {
      final result = await localDatasource.getComicById(id: id);
      return Right(result);
    } on LocalExeption {
      return const Left(DatabaseFailure('Local Database Failure'));
    }
  }

  @override
  Future<Either<Failure, int>> insertIssue({required Comic comic}) async {
    try {
      final result = await localDatasource.insertComic(comic: comic);
      return Right(result);
    } on LocalExeption {
      return const Left(DatabaseFailure('Local Database Failure'));
    }
  }

  @override
  Future<Either<Failure, int>> updateComic({required Comic comic}) async {
    try {
      final result = await localDatasource.updateComic(comic: comic);
      return Right(result);
    } on LocalExeption {
      return const Left(DatabaseFailure('Local Database Failure'));
    }
  }

  
  @override
  Future<Either<Failure, int>> deleteComic({required int id}) async {
    try {
      final result = await localDatasource.deleteComic(id: id);
      return Right(result);
    } on LocalExeption {
      return const Left(DatabaseFailure('Local Database Failure'));
    }
  }



  







}
