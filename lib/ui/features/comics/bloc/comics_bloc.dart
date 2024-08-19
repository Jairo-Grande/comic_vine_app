import 'package:comic_vine_app/domain/entities/comic_entity.dart';
import 'package:comic_vine_app/domain/entities/issue_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comic_vine_app/domain/use_cases/get_comic_vine_api.dart';

part 'comics_event.dart';
part 'comics_state.dart';

class IssueBloc extends Bloc<IssueEvent, IssueState> {
  final GetComicVineApi getComicVineApi;
  IssueBloc(this.getComicVineApi) : super(IssueState()) {
    on<LoadIssues>(_loadIssues);
    on<LoadIssueDetails>(_loadIssueDetail);
  }

  _loadIssues(LoadIssues event, Emitter emit) async {
    if (state.loadingMoreData || !state.hasMore) return;

    if (event.loadingMoreData != null && event.loadingMoreData == true) {
      emit(state.copyWith(loadingMoreData: true));
    } else {
      emit(state.copyWith(issuesLoading: true));
    }

    final response = await getComicVineApi.getIssues(offset: event.offset);
    response.fold(
      (failure) {
        emit(state.copyWith(
            issuesError: failure.message,
            issuesLoading: false,
            loadingMoreData: false));
      },
      (issues) {
        final hasMore = issues.results!.length == 10;
        Issues? updatedIssues = issues;
        //Add new issues to paginate.
        if (state.issues != null) {
          updatedIssues = state.issues?.copyWith(
            results: [...?state.issues?.results, ...issues.results!],
          );
        }

        if (state.loadingMoreData) {
          emit(state.copyWith(
              issues: updatedIssues, loadingMoreData: false, hasMore: hasMore));
        } else {
          emit(state.copyWith(
            issues: updatedIssues,
            issuesLoading: false,
          ));
        }
      },
    );
  }


  _loadIssueDetail(LoadIssueDetails event, Emitter emit) async {
    emit(state.copyWith(issueDetailsLoading: true, issueDetails: event.comic));
    final response = await getComicVineApi.getIssueById(id: event.comic.id!);
    response.fold(
      (failure) {
        emit(state.copyWith(
            issuesError: failure.message, issueDetailsLoading: false));
      },
      (issueDetails) {
        //Adding list of details at issue. teamCredits, person credits, Etc.
        final updatedIssueDetails = state.issueDetails!.copyWith(
          personCredits: issueDetails.personCredits,
          characterCredits: issueDetails.characterCredits,
          teamCredits: issueDetails.teamCredits,
          locationCredits: issueDetails.locationCredits,
          conceptCredits: issueDetails.conceptCredits,
        );

        emit(state.copyWith(
          issueDetails: updatedIssueDetails,
          issueDetailsLoading: false,
        ));
      },
    );
  }
}
