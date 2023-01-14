import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_popular_movies.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/all_popular_movies_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_notifier_test.mocks.dart';

@GenerateMocks([GetAllPopularMovies])
void main() {
  late MockGetAllPopularMovies mockGetPopularMovies;
  late AllPopularMoviesNotifier popularMoviesNotifier;
  late int countListenerCall;

  setUp(() {
    countListenerCall = 0;
    mockGetPopularMovies = MockGetAllPopularMovies();
    popularMoviesNotifier = AllPopularMoviesNotifier(mockGetPopularMovies)
      ..addListener(() {
        countListenerCall++;
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

  final testMovieList = <Movie>[tMovie];

  test('should change state to DataLoading when usecase is called', () async {
    // arrange
    when(mockGetPopularMovies.execute())
        .thenAnswer((_) async => Right(testMovieList));
    // act
    popularMoviesNotifier.fetchPopularMovies();
    // assert
    expect(popularMoviesNotifier.enumStateRequest, EnumStateRequest.DataLoading);
    expect(countListenerCall, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularMovies.execute())
        .thenAnswer((_) async => Right(testMovieList));
    // act
    await popularMoviesNotifier.fetchPopularMovies();
    // assert
    expect(popularMoviesNotifier.enumStateRequest, EnumStateRequest.DataLoaded);
    expect(popularMoviesNotifier.movies, testMovieList);
    expect(countListenerCall, 2);
  });

  test('should return error when data is not successful', () async {
    // arrange
    when(mockGetPopularMovies.execute())
        .thenAnswer((_) async => Left(FailureServer('Server Failure')));
    // act
    await popularMoviesNotifier.fetchPopularMovies();
    // assert
    expect(popularMoviesNotifier.enumStateRequest, EnumStateRequest.DataError);
    expect(popularMoviesNotifier.message, 'Server Failure');
    expect(countListenerCall, 2);
  });
}
