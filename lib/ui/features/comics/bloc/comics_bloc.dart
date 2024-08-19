import 'package:comic_vine_app/data/failure.dart';
import 'package:comic_vine_app/data/model/issues_model.dart';

import 'package:comic_vine_app/domain/entities/comic_entity.dart';
import 'package:comic_vine_app/domain/entities/issue_entity.dart';
import 'package:comic_vine_app/domain/use_cases/get_comic_vine_local.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comic_vine_app/domain/use_cases/get_comic_vine_api.dart';

part 'comics_event.dart';
part 'comics_state.dart';

class IssueBloc extends Bloc<IssueEvent, IssueState> {
  final GetComicVineApi getComicVineApi;
  final GetComicVineLocal getComicVineLocal;

  IssueBloc(this.getComicVineApi, this.getComicVineLocal)
      : super(IssueState()) {
    //Db evemts to add issues.
    on<LoadIssues>(_loadIssues);
    on<LoadIssueDetails>(_loadIssueDetail);

    //event to find comic in API services
    on<FetchIssueByIdAndIsertIntoDB>(_fetchIssueAndInsertIntoDB);
    on<InsertIssueDB>(_inserIssuesDB);
  }

  _loadIssues(LoadIssues event, Emitter emit) async {
    //pagination logic.
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
        IssuesModel? updatedIssues = issues;
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
    if (event.deleteRegister != null && event.deleteRegister == true) {
      emit(state.copyWith(issueDetailsLoading: true));
      //delete register.
      await getComicVineLocal.deleteComic(id: state.issueDetails!.id!);
    } else {
      emit(state.copyWith(issueDetails: event.comic));
    }

    //search comic in localDatabase. already exist dont will searh it in server.
    final responseCache = await findInDB(
        comicId: state.issueDetails!.id!, getComicVineLocal: getComicVineLocal);

    responseCache.fold(
      (failure) {
        //if no exist in local db, serach in server and insert in db.
        add(FetchIssueByIdAndIsertIntoDB(comicId: state.issueDetails!.id!));
      },
      (comic) {
        final updatedIssueDetails = state.issueDetails!.copyWith(
          personCredits: comic.personCredits,
          characterCredits: comic.characterCredits,
          teamCredits: comic.teamCredits,
          locationCredits: comic.locationCredits,
          conceptCredits: comic.conceptCredits,
        );

        try {
          emit(state.copyWith(
            issueDetails: updatedIssueDetails,
            issueDetailsLoading: false,
          ));
        } catch (e) {
          emit(state.copyWith(
            issuesError: 'Error showing data from database',
            issueDetailsLoading: false,
          ));
        }
      },
    );
  }

  _fetchIssueAndInsertIntoDB(
      FetchIssueByIdAndIsertIntoDB event, Emitter emit) async {
    final response = await getComicVineApi.getIssueById(id: event.comicId);

    response.fold((failure) {
      emit(state.copyWith(
          issuesError: failure.message, issueDetailsLoading: false));
    }, (issueDetails) {
      final updatedIssueDetails = state.issueDetails!.copyWith(
        personCredits: issueDetails.personCredits,
        characterCredits: issueDetails.characterCredits,
        teamCredits: issueDetails.teamCredits,
        locationCredits: issueDetails.locationCredits,
        conceptCredits: issueDetails.conceptCredits,
      );

      add(InsertIssueDB(
          comicVineLocal: getComicVineLocal, comic: updatedIssueDetails));

      emit(state.copyWith(
          issueDetails: updatedIssueDetails, issueDetailsLoading: false));
    });
  }

  _inserIssuesDB(InsertIssueDB event, Emitter emit) async {
    final response = await event.comicVineLocal.insertIssue(comic: event.comic);
    response.fold(
      (failure) {
        try {
          emit(state.copyWith(
              issueDetailsLoading: false, issueDetails: event.comic));
        } catch (e) {
          emit(state.copyWith(
            issuesError: 'Error insert data in database',
            issueDetailsLoading: false,
          ));
        }
      },
      (response) {},
    );
  }
}

Future<Either<Failure, Comic>> findInDB(
    {
  required GetComicVineLocal getComicVineLocal,
  required int comicId}) async {
  final responseCache = await getComicVineLocal.getIssueById(id: comicId);
  return responseCache;
}
