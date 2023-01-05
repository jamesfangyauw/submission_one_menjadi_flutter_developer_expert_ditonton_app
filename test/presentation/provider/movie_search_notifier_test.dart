import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/search_all_movies.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/all_movie_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_search_notifier_test.mocks.dart';

@GenerateMocks([SearchAllMovies])
void main() {
  late All_MovieSearchNotifier movieSearchNotifier;
  late MockSearchMovies mockSearchMovies;
  late int countListenerCall;

  setUp(() {
    countListenerCall = 0;
    mockSearchMovies = MockSearchMovies();
    movieSearchNotifier = All_MovieSearchNotifier(searchMovies: mockSearchMovies)
      ..addListener(() {
        countListenerCall += 1;
      });
  });

  final tMovieModel = Movie(
    adultMovie: false,
    backdropPathMovie: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIdsMovie: [14, 28],
    idMovie: 557,
    originalTitleMovie: 'Spider-Man',
    overviewMovie:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularityMovie: 60.441,
    posterPathMovie: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDateMovie: '2002-05-01',
    titleMovie: 'Spider-Man',
    videoMovie: false,
    voteAverageMovie: 7.2,
    voteCountMovie: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  final tQuery = 'spiderman';

  group('search movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      // act
      movieSearchNotifier.fetchMovieSearch(tQuery);
      // assert
      expect(movieSearchNotifier.state, EnumStateRequest.DataLoading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await movieSearchNotifier.fetchMovieSearch(tQuery);
      // assert
      expect(movieSearchNotifier.state, EnumStateRequest.DataLoaded);
      expect(movieSearchNotifier.searchResult, tMovieList);
      expect(countListenerCall, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(FailureServer('Server Failure')));
      // act
      await movieSearchNotifier.fetchMovieSearch(tQuery);
      // assert
      expect(movieSearchNotifier.state, EnumStateRequest.DataError);
      expect(movieSearchNotifier.message, 'Server Failure');
      expect(countListenerCall, 2);
    });
  });
}
