part of 'comics_bloc.dart';

class IssueState {
  //getIssues
  final bool issuesLoading;
  final String? issuesError;
  final IssuesModel? issues;
  final List<ComicsModel>? filteredIssues;

  //getIssueDetails
  final bool issueDetailsLoading;
  final String? issueDetailsError;
  final ComicsModel? issueDetails;

//pagination Logic here.
  final bool hasMore;
  final bool loadingMoreData;

  IssueState(
      {
      this.issues,
      this.filteredIssues,
      this.issuesLoading = false,
      this.issuesError,


      this.issueDetailsLoading = false,
      this.issueDetailsError,
      this.issueDetails,


      this.hasMore = true,
      this.loadingMoreData = false});

  IssueState copyWith(
          {
            bool? issuesLoading,
          String? issuesError,
          IssuesModel? issues,
          List<ComicsModel>? filteredIssues,

          bool? issueDetailsLoading,
          String? issueDetailsError,
          ComicsModel? issueDetails,

          bool? hasMore,
          bool? loadingMoreData
          }) =>
      IssueState(
          issues: issues ?? this.issues,
          issuesLoading: issuesLoading ?? this.issuesLoading,
          issuesError: issuesError ?? this.issuesError,
          filteredIssues: filteredIssues?? this.filteredIssues,

          issueDetailsLoading: issueDetailsLoading ?? this.issueDetailsLoading,
          issueDetailsError: issueDetailsError ?? this.issueDetailsError,
          issueDetails: issueDetails ?? this.issueDetails,

          hasMore: hasMore ?? this.hasMore,
          loadingMoreData: loadingMoreData ?? this.loadingMoreData);
}
