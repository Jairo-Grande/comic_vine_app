import 'dart:io';

import 'package:comic_vine_app/data/datasource/remote_datasource.dart';
import 'package:comic_vine_app/data/exeption.dart';
import 'package:comic_vine_app/data/failure.dart';
import 'package:comic_vine_app/data/model/issues_model.dart';


import 'package:comic_vine_app/domain/repositories/comic_vine_repository.dart';
import 'package:dartz/dartz.dart';


class ComicVineRepositoryImpl implements ComicVineRepository {
  final RemoteDataSource remoteDatasource;
  ComicVineRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, IssuesModel>> fetchIssues({int? offset}) async {
    try {
      final result = await remoteDatasource.fetchIssues(offset: offset);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, ComicsModel>> fetchIssueById({int? id}) async{
   try {
      final result = await remoteDatasource.fetchIssueById(id:id);
      return Right(result.results!.first);
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
