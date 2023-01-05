import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_movie_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetAllMovieRecommendations theusecase;
  late AllMovieRepoMock mckMovieRepository;

  setUp(() {
    mckMovieRepository = AllMovieRepoMock();
    theusecase = GetAllMovieRecommendations(mckMovieRepository);
  });
  final testId = 1;
  final testMovies = <Movie>[];
  test('should get list of movie recommendations from the repository',
      () async {
    // arrange
    when(mckMovieRepository.getMovieRecommendations(testId))
        .thenAnswer((_) async => Right(testMovies));
    // act
    final theResult = await theusecase.execute(testId);
    // assert
    expect(theResult, Right(testMovies));
  });
}
