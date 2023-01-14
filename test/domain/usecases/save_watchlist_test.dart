import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/save_all_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveAllWatchListTheMovies theusecase;
  late AllMovieRepoMock mockMoviesRepository;

  setUp(() {
    mockMoviesRepository = AllMovieRepoMock();
    theusecase = SaveAllWatchListTheMovies(mockMoviesRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockMoviesRepository.saveWatchlist(testTheMovieDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final theresult = await theusecase.execute(testTheMovieDetail);
    // assert
    verify(mockMoviesRepository.saveWatchlist(testTheMovieDetail));
    expect(theresult, Right('Added to Watchlist'));
  });
}
