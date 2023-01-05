import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/remove_all_watchlist_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper_tv_show.mocks.dart';

void main() {
  late RemoveAllWatchlistTVShow removeAllWatchlistTvShow;
  late TvShowRepoMock tVShowRepositoryMock;

  setUp(() {
    tVShowRepositoryMock = TvShowRepoMock();
    removeAllWatchlistTvShow = RemoveAllWatchlistTVShow(tVShowRepositoryMock);
  });

  test('should remove watchlist tv show from repository', () async {
    // arrange
    when(tVShowRepositoryMock.removeWatchlistTvShow(testTVShowDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final theresult = await removeAllWatchlistTvShow.execute(testTVShowDetail);
    // assert
    verify(tVShowRepositoryMock.removeWatchlistTvShow(testTVShowDetail));
    expect(theresult, Right('Removed from watchlist'));
  });
}
