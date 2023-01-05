import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/search_all_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchAllMovies theusecase;
  late AllMovieRepoMock mockMoviesRepository;

  setUp(() {
    mockMoviesRepository = AllMovieRepoMock();
    theusecase = SearchAllMovies(mockMoviesRepository);
  });

  final testMovies = <Movie>[];
  final testQuery = 'Spiderman';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMoviesRepository.searchMovies(testQuery))
        .thenAnswer((_) async => Right(testMovies));
    // act
    final theresult = await theusecase.execute(testQuery);
    // assert
    expect(theresult, Right(testMovies));
  });
}
