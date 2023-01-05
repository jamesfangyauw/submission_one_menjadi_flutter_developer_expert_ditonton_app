import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/remove_all_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveAllWatchlistTvShow theusecase;
  late AllMovieRepoMock mockMoviesRepository;

  setUp(() {
    mockMoviesRepository = AllMovieRepoMock();
    theusecase = RemoveAllWatchlistTvShow(mockMoviesRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockMoviesRepository.removeWatchlist(testTheMovieDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final theresult = await theusecase.execute(testTheMovieDetail);
    // assert
    verify(mockMoviesRepository.removeWatchlist(testTheMovieDetail));
    expect(theresult, Right('Removed from watchlist'));
  });
}
