import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_top_rated_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetAllTopRatedMovies theusecase;
  late AllMovieRepoMock mockMoviesRepository;

  setUp(() {
    mockMoviesRepository = AllMovieRepoMock();
    theusecase = GetAllTopRatedMovies(mockMoviesRepository);
  });

  final testMovies = <Movie>[];

  test('should get list of movies from repository', () async {
    // arrange
    when(mockMoviesRepository.getTopRatedMovies())
        .thenAnswer((_) async => Right(testMovies));
    // act
    final theresult = await theusecase.execute();
    // assert
    expect(theresult, Right(testMovies));
  });
}
