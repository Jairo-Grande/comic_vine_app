part of 'comics_bloc.dart';

abstract class IssueEvent {}

class LoadIssues extends IssueEvent {
  int? offset;
  bool? loadingMoreData;
  LoadIssues({this.offset, this.loadingMoreData});
}

class LoadIssueDetails extends IssueEvent {
  Comic comic;
  LoadIssueDetails(this.comic);
}
