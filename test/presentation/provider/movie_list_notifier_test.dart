import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_now_playing_movies.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_popular_movies.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_top_rated_movies.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/all_movie_list_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_notifier_test.mocks.dart';

@GenerateMocks([GetAllNowPlayingMovies, GetAllPopularMovies, GetAllTopRatedMovies])
void main() {
  late AllMovieListNotifier movieListNotifier;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late int countListenerCall;

  setUp(() {
    countListenerCall = 0;
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieListNotifier = AllMovieListNotifier(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    )..addListener(() {
        countListenerCall += 1;
      });
  });

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
  final tMovieList = <Movie>[tMovie];

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(movieListNotifier.nowPlayingState, equals(EnumStateRequest.DataEmpty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      movieListNotifier.fetchNowPlayingMovies();
      // assert
      verify(mockGetNowPlayingMovies.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      movieListNotifier.fetchNowPlayingMovies();
      // assert
      expect(movieListNotifier.nowPlayingState, EnumStateRequest.DataLoading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await movieListNotifier.fetchNowPlayingMovies();
      // assert
      expect(movieListNotifier.nowPlayingState, EnumStateRequest.DataLoaded);
      expect(movieListNotifier.nowPlayingMovies, tMovieList);
      expect(countListenerCall, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(FailureServer('Server Failure')));
      // act
      await movieListNotifier.fetchNowPlayingMovies();
      // assert
      expect(movieListNotifier.nowPlayingState, EnumStateRequest.DataError);
      expect(movieListNotifier.message, 'Server Failure');
      expect(countListenerCall, 2);
    });
  });

  group('popular movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      movieListNotifier.fetchPopularMovies();
      // assert
      expect(movieListNotifier.popularMoviesState, EnumStateRequest.DataLoading);
      // verify(movieListNotifier.setState(RequestState.Loading));
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await movieListNotifier.fetchPopularMovies();
      // assert
      expect(movieListNotifier.popularMoviesState, EnumStateRequest.DataLoaded);
      expect(movieListNotifier.popularMovies, tMovieList);
      expect(countListenerCall, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(FailureServer('Server Failure')));
      // act
      await movieListNotifier.fetchPopularMovies();
      // assert
      expect(movieListNotifier.popularMoviesState, EnumStateRequest.DataError);
      expect(movieListNotifier.message, 'Server Failure');
      expect(countListenerCall, 2);
    });
  });

  group('top rated movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      movieListNotifier.fetchTopRatedMovies();
      // assert
      expect(movieListNotifier.topRatedMoviesState, EnumStateRequest.DataLoading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await movieListNotifier.fetchTopRatedMovies();
      // assert
      expect(movieListNotifier.topRatedMoviesState, EnumStateRequest.DataLoaded);
      expect(movieListNotifier.topRatedMovies, tMovieList);
      expect(countListenerCall, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(FailureServer('Server Failure')));
      // act
      await movieListNotifier.fetchTopRatedMovies();
      // assert
      expect(movieListNotifier.topRatedMoviesState, EnumStateRequest.DataError);
      expect(movieListNotifier.message, 'Server Failure');
      expect(countListenerCall, 2);
    });
  });
}
