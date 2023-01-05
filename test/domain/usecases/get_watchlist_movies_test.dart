import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_watchlist_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetAllWatchlistMovies theusecase;
  late AllMovieRepoMock mockMoviesRepository;

  setUp(() {
    mockMoviesRepository = AllMovieRepoMock();
    theusecase = GetAllWatchlistMovies(mockMoviesRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMoviesRepository.getWatchlistMovies())
        .thenAnswer((_) async => Right(testTheMovieList));
    // act
    final theresult = await theusecase.execute();
    // assert
    expect(theresult, Right(testTheMovieList));
  });
}
