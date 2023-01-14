import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_movie_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_movie_recommendations.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_watchlist_status.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/remove_all_watchlist.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/save_all_watchlist.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/all_movie_detail_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetAllMovieDetail,
  GetAllMovieRecommendations,
  GetAllWatchListTheMoviesStatus,
  SaveAllWatchListTheMovies,
  RemoveAllWatchlistTheMovies,
])
void main() {
  late AllMovieDetailNotifier movieDetailNotifier;
  late MockGetAllMovieDetail mockGetMovieDetail;
  late MockGetAllMovieRecommendations mockGetMovieRecommendations;
  late MockGetAllWatchListTheMoviesStatus mockGetWatchlistStatus;
  late MockSaveAllWatchListTheMovies mockSaveWatchlist;
  late MockRemoveAllWatchlistTheMovies mockRemoveWatchlist;
  late int countlistenerCall;

  setUp(() {
    countlistenerCall = 0;
    mockGetMovieDetail = MockGetAllMovieDetail();
    mockGetMovieRecommendations = MockGetAllMovieRecommendations();
    mockGetWatchlistStatus = MockGetAllWatchListTheMoviesStatus();
    mockSaveWatchlist = MockSaveAllWatchListTheMovies();
    mockRemoveWatchlist = MockRemoveAllWatchlistTheMovies();
    movieDetailNotifier = AllMovieDetailNotifier(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    )..addListener(() {
        countlistenerCall += 1;
      });
  });

  final tId = 1;

  final tMovie = Movie(
    adultMovie: false,
    backdropPathMovie: 'backdropPath',
    genreIdsMovie: [1, 2, 3],
    idMovie: 1,
    originalTitleMovie: 'originalTitle',
    overviewMovie: 'overview',
    popularityMovie: 1,
    posterPathMovie: 'posterPath',
    releaseDateMovie: 'releaseDate',
    titleMovie: 'title',
    videoMovie: false,
    voteAverageMovie: 1,
    voteCountMovie: 1,
  );
  final tMovies = <Movie>[tMovie];

  void _arrangeUsecase() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => Right(testTheMovieDetail));
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  group('Get Movie Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await movieDetailNotifier.fetchMovieDetail(tId);
      // assert
      verify(mockGetMovieDetail.execute(tId));
      verify(mockGetMovieRecommendations.execute(tId));
    });

    test('should change state to DataLoading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      movieDetailNotifier.fetchMovieDetail(tId);
      // assert
      expect(movieDetailNotifier.movieState, EnumStateRequest.DataLoading);
      expect(countlistenerCall, 1);
    });

    test('should change movie when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await movieDetailNotifier.fetchMovieDetail(tId);
      // assert
      expect(movieDetailNotifier.movieState, EnumStateRequest.DataLoaded);
      expect(movieDetailNotifier.movie, testTheMovieDetail);
      expect(countlistenerCall, 3);
    });

    test('should change recommendation movies when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await movieDetailNotifier.fetchMovieDetail(tId);
      // assert
      expect(movieDetailNotifier.movieState, EnumStateRequest.DataLoaded);
      expect(movieDetailNotifier.movieRecommendations, tMovies);
    });
  });

  group('Get Movie Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await movieDetailNotifier.fetchMovieDetail(tId);
      // assert
      verify(mockGetMovieRecommendations.execute(tId));
      expect(movieDetailNotifier.movieRecommendations, tMovies);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await movieDetailNotifier.fetchMovieDetail(tId);
      // assert
      expect(movieDetailNotifier.recommendationState, EnumStateRequest.DataLoaded);
      expect(movieDetailNotifier.movieRecommendations, tMovies);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testTheMovieDetail));
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Left(FailureServer('Failed')));
      // act
      await movieDetailNotifier.fetchMovieDetail(tId);
      // assert
      expect(movieDetailNotifier.recommendationState, EnumStateRequest.DataError);
      expect(movieDetailNotifier.msgge, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await movieDetailNotifier.loadWatchlistStatus(1);
      // assert
      expect(movieDetailNotifier.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTheMovieDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatus.execute(testTheMovieDetail.idMovie))
          .thenAnswer((_) async => true);
      // act
      await movieDetailNotifier.addWatchlist(testTheMovieDetail);
      // assert
      verify(mockSaveWatchlist.execute(testTheMovieDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlist.execute(testTheMovieDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatus.execute(testTheMovieDetail.idMovie))
          .thenAnswer((_) async => false);
      // act
      await movieDetailNotifier.removeFromWatchlist(testTheMovieDetail);
      // assert
      verify(mockRemoveWatchlist.execute(testTheMovieDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTheMovieDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatus.execute(testTheMovieDetail.idMovie))
          .thenAnswer((_) async => true);
      // act
      await movieDetailNotifier.addWatchlist(testTheMovieDetail);
      // assert
      verify(mockGetWatchlistStatus.execute(testTheMovieDetail.idMovie));
      expect(movieDetailNotifier.isAddedToWatchlist, true);
      expect(movieDetailNotifier.watchlistMessage, 'Added to Watchlist');
      expect(countlistenerCall, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTheMovieDetail))
          .thenAnswer((_) async => Left(FailureDB('Failed')));
      when(mockGetWatchlistStatus.execute(testTheMovieDetail.idMovie))
          .thenAnswer((_) async => false);
      // act
      await movieDetailNotifier.addWatchlist(testTheMovieDetail);
      // assert
      expect(movieDetailNotifier.watchlistMessage, 'Failed');
      expect(countlistenerCall, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Left(FailureServer('Server Failure')));
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tMovies));
      // act
      await movieDetailNotifier.fetchMovieDetail(tId);
      // assert
      expect(movieDetailNotifier.movieState, EnumStateRequest.DataError);
      expect(movieDetailNotifier.msgge, 'Server Failure');
      expect(countlistenerCall, 2);
    });
  });
}
