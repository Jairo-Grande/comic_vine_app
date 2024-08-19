import 'package:comic_vine_app/data/failure.dart';

import 'package:comic_vine_app/domain/entities/comic_entity.dart';

import 'package:dartz/dartz.dart';

abstract class ComicVineLocalRepository {  
 Future<Either<Failure, Comic>> getIssueById({required int id});
 Future<Either<Failure, int>> insertIssue({required Comic comic});
 Future<Either<Failure, int>> updateComic({required Comic comic});
 Future<Either<Failure, int>> deleteComic({required int id});


 

}
