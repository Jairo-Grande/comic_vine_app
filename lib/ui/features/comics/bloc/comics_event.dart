part of 'comics_bloc.dart';

abstract class IssueEvent {}

class LoadIssues extends IssueEvent {
  int? offset;
  bool? loadingMoreData;
  LoadIssues({this.offset, this.loadingMoreData});
}

class LoadIssueDetails extends IssueEvent {
  bool? deleteRegister;
  ComicsModel? comic;
  LoadIssueDetails(this.comic, this.deleteRegister);
}

class InsertIssueDB extends IssueEvent {
  GetComicVineLocal comicVineLocal;
  ComicsModel comic;
  InsertIssueDB({required this.comicVineLocal, required this.comic});
}

class FetchIssueByIdAndIsertIntoDB extends IssueEvent {
  final int comicId;
  FetchIssueByIdAndIsertIntoDB({required this.comicId});
}

