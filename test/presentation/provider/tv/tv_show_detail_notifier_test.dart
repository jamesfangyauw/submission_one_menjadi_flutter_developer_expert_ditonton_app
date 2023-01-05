import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_watchlist_tv_show_status.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/remove_all_watchlist_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/save_all_watchlist_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_tv_show_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_tv_show_recommendations.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetAllTVShowDetail,
  GetTVShowRecommendations,
  GetAllWatchListStatusTVShow,
  SaveAllWatchlistTVShow,
  RemoveAllWatchlistTVShow,
])
void main() {
  late TVShowDetailNotifier tvShowDetailNotifier;
  late GetTVShowDetailMock getTVShowDetailmock;
  late GetTVShowRecommendationsMock getTVShowRecommendationsmock;
  late GetWatchListTvShowStatusMock getWatchlistTvShowStatusmock;
  late SaveWatchlistTvShowMock saveWatchlistTvShowmock;
  late RemoveWatchlistTvShowMock removeWatchlistTvShowmock;
  late int countListenerCall;

  setUp(() {
    countListenerCall = 0;
    getTVShowDetailmock = GetTVShowDetailMock();
    getTVShowRecommendationsmock = GetTVShowRecommendationsMock();
    getWatchlistTvShowStatusmock = GetWatchListTvShowStatusMock();
    saveWatchlistTvShowmock = SaveWatchlistTvShowMock();
    removeWatchlistTvShowmock = RemoveWatchlistTvShowMock();
    tvShowDetailNotifier = TVShowDetailNotifier(
      getAllTVShowDetail: getTVShowDetailmock,
      getAllTVShowRecommendations: getTVShowRecommendationsmock,
      getAllTVShowWatchListStatus: getWatchlistTvShowStatusmock,
      saveAllTVShowWatchlist: saveWatchlistTvShowmock,
      removeAllTvShowWatchlist: removeWatchlistTvShowmock,
    )..addListener(() {
        countListenerCall = countListenerCall + 1;
      });
  });

  final testtvShowId = 1;

  final testTVShow = TVEntities(
    pathBackdrop: 'backdropPath',
    genreIdsTv: [1, 2, 3],
    idTv: 1,
    name_original: 'originalTitle',
    tv_overview: 'overview',
    tv_popularity: 1,
    path_poster: 'posterPath',
    date_first_show:  'releaseDate',
    nameTv : 'title',
    language_original: 'EN',
    tv_voteAverage: 1,
    tv_voteCount: 1,
  );
  final testTVsShow = <TVEntities>[testTVShow];

  void _arrangeUsecase() {
    when(getTVShowDetailmock.execute(testtvShowId))
        .thenAnswer((_) async => Right(testTVShowDetail));
    when(getTVShowRecommendationsmock.execute(testtvShowId))
        .thenAnswer((_) async => Right(testTVsShow));
  }

  group('Get TV Show Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await tvShowDetailNotifier.fetchTVDetail(testtvShowId);
      // assert
      verify(getTVShowDetailmock.execute(testtvShowId));
      verify(getTVShowRecommendationsmock.execute(testtvShowId));
    });

    test('should change state to DataLoading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      tvShowDetailNotifier.fetchTVDetail(testtvShowId);
      // assert
      expect(tvShowDetailNotifier.tvShowState, EnumStateRequest.DataLoading);
      expect(countListenerCall, 1);
    });

    test('should change tv show when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await tvShowDetailNotifier.fetchTVDetail(testtvShowId);
      // assert
      expect(tvShowDetailNotifier.tvShowState, EnumStateRequest.DataLoaded);
      expect(tvShowDetailNotifier.tvDetail, testTVShowDetail);
      expect(countListenerCall, 3);
    });

    test('should change recommendation tvs show when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await tvShowDetailNotifier.fetchTVDetail(testtvShowId);
      // assert
      expect(tvShowDetailNotifier.tvShowState, EnumStateRequest.DataLoaded);
      expect(tvShowDetailNotifier.tvShowRecommendations, testTVsShow);
    });
  });

  group('Get TV Show Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await tvShowDetailNotifier.fetchTVDetail(testtvShowId);
      // assert
      verify(getTVShowRecommendationsmock.execute(testtvShowId));
      expect(tvShowDetailNotifier.tvShowRecommendations, testTVsShow);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await tvShowDetailNotifier.fetchTVDetail(testtvShowId);
      // assert
      expect(tvShowDetailNotifier.tvShowRecommendationState, EnumStateRequest.DataLoaded);
      expect(tvShowDetailNotifier.tvShowRecommendations, testTVsShow);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(getTVShowDetailmock.execute(testtvShowId))
          .thenAnswer((_) async => Right(testTVShowDetail));
      when(getTVShowRecommendationsmock.execute(testtvShowId))
          .thenAnswer((_) async => Left(FailureServer('Failed')));
      // act
      await tvShowDetailNotifier.fetchTVDetail(testtvShowId);
      // assert
      expect(tvShowDetailNotifier.tvShowRecommendationState, EnumStateRequest.DataError);
      expect(tvShowDetailNotifier.mssg, 'Failed');
    });
  });

  group('Watchlist Tv Show', () {
    test('should get the watchlist tv show status', () async {
      // arrange
      when(getWatchlistTvShowStatusmock.execute(1)).thenAnswer((_) async => true);
      // act
      await tvShowDetailNotifier.tvShowLoadWatchlistStatus(1);
      // assert
      expect(tvShowDetailNotifier.tvShowAddedToWatchlist, true);
    });

    test('should execute save watchlist tv show when function called', () async {
      // arrange
      when(saveWatchlistTvShowmock.execute(testTVShowDetail))
          .thenAnswer((_) async => Right('Success'));
      when(getWatchlistTvShowStatusmock.execute(testTVShowDetail.tvShowId))
          .thenAnswer((_) async => true);
      // act
      await tvShowDetailNotifier.addWatchlistTvShow(testTVShowDetail);
      // assert
      verify(saveWatchlistTvShowmock.execute(testTVShowDetail));
    });

    test('should execute remove watchlist tv show when function called', () async {
      // arrange
      when(removeWatchlistTvShowmock.execute(testTVShowDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(getWatchlistTvShowStatusmock.execute(testTVShowDetail.tvShowId))
          .thenAnswer((_) async => false);
      // act
      await tvShowDetailNotifier.removeFromWatchlist(testTVShowDetail);
      // assert
      verify(removeWatchlistTvShowmock.execute(testTVShowDetail));
    });

    test('should update watchlist tv show status when add watchlist tv show success', () async {
      // arrange
      when(saveWatchlistTvShowmock.execute(testTVShowDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(getWatchlistTvShowStatusmock.execute(testTVShowDetail.tvShowId))
          .thenAnswer((_) async => true);
      // act
      await tvShowDetailNotifier.addWatchlistTvShow(testTVShowDetail);
      // assert
      verify(getWatchlistTvShowStatusmock.execute(testTVShowDetail.tvShowId));
      expect(tvShowDetailNotifier.tvShowAddedToWatchlist, true);
      expect(tvShowDetailNotifier.tvShowWatchlistMessage, 'Added to Watchlist');
      expect(countListenerCall, 1);
    });

    test('should update watchlist tv show message when add watchlist tv show failed', () async {
      // arrange
      when(saveWatchlistTvShowmock.execute(testTVShowDetail))
          .thenAnswer((_) async => Left(FailureDB('Failed')));
      when(getWatchlistTvShowStatusmock.execute(testTVShowDetail.tvShowId))
          .thenAnswer((_) async => false);
      // act
      await tvShowDetailNotifier.addWatchlistTvShow(testTVShowDetail);
      // assert
      expect(tvShowDetailNotifier.tvShowWatchlistMessage, 'Failed');
      expect(countListenerCall, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is not successful', () async {
      // arrange
      when(getTVShowDetailmock.execute(testtvShowId))
          .thenAnswer((_) async => Left(FailureServer('Server Failure')));
      when(getTVShowRecommendationsmock.execute(testtvShowId))
          .thenAnswer((_) async => Right(testTVsShow));
      // act
      await tvShowDetailNotifier.fetchTVDetail(testtvShowId);
      // assert
      expect(tvShowDetailNotifier.tvShowState, EnumStateRequest.DataError);
      expect(tvShowDetailNotifier.mssg, 'Server Failure');
      expect(countListenerCall, 2);
    });
  });
}
