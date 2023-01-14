import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_top_rated_movies.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/top_rated_movies_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_notifier_test.mocks.dart';

@GenerateMocks([GetAllTopRatedMovies])
void main() {
  late MockGetAllTopRatedMovies getTopRatedMoviesMock;
  late TopRatedMoviesNotifier topRatedMoviesNotifier;
  late int countListenerCall;

  setUp(() {
    countListenerCall = 0;
    getTopRatedMoviesMock = MockGetAllTopRatedMovies();
    topRatedMoviesNotifier = TopRatedMoviesNotifier(getTopRatedMovies: getTopRatedMoviesMock)
      ..addListener(() {
        countListenerCall++;
      });
  });

  final testMovie = Movie(
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

  final testMovieList = <Movie>[testMovie];

  test('should change state to DataLoading when usecase is called', () async {
    // arrange
    when(getTopRatedMoviesMock.execute())
        .thenAnswer((_) async => Right(testMovieList));
    // act
    topRatedMoviesNotifier.fetchTopRatedMovies();
    // assert
    expect(topRatedMoviesNotifier.state, EnumStateRequest.DataLoading);
    expect(countListenerCall, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(getTopRatedMoviesMock.execute())
        .thenAnswer((_) async => Right(testMovieList));
    // act
    await topRatedMoviesNotifier.fetchTopRatedMovies();
    // assert
    expect(topRatedMoviesNotifier.state, EnumStateRequest.DataLoaded);
    expect(topRatedMoviesNotifier.movies, testMovieList);
    expect(countListenerCall, 2);
  });

  test('should return error when data is not successful', () async {
    // arrange
    when(getTopRatedMoviesMock.execute())
        .thenAnswer((_) async => Left(FailureServer('Server Failure')));
    // act
    await topRatedMoviesNotifier.fetchTopRatedMovies();
    // assert
    expect(topRatedMoviesNotifier.state, EnumStateRequest.DataError);
    expect(topRatedMoviesNotifier.message, 'Server Failure');
    expect(countListenerCall, 2);
  });
}
