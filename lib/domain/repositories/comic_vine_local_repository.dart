import 'package:comic_vine_app/data/failure.dart';
import 'package:comic_vine_app/data/model/issues_model.dart';



import 'package:dartz/dartz.dart';

abstract class ComicVineLocalRepository {  
 Future<Either<Failure, ComicsModel>> getIssueById({required int id});
 Future<Either<Failure, int>> insertIssue({required ComicsModel comic});
 Future<Either<Failure, int>> updateComic({required ComicsModel comic});
 Future<Either<Failure, int>> deleteComic({required int id});
}
