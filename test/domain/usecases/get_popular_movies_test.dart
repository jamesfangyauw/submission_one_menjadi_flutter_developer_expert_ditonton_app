import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_popular_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetAllPopularMovies theusecase;
  late AllMovieRepoMock mockMoviesRpository;

  setUp(() {
    mockMoviesRpository = AllMovieRepoMock();
    theusecase = GetAllPopularMovies(mockMoviesRpository);
  });

  final testMovies = <Movie>[];

  group('GetPopularMovies Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        // arrange
        when(mockMoviesRpository.getPopularMovies())
            .thenAnswer((_) async => Right(testMovies));
        // act
        final theresult = await theusecase.execute();
        // assert
        expect(theresult, Right(testMovies));
      });
    });
  });
}
