import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/save_all_watchlist_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper_tv_show.mocks.dart';

void main() {
  late SaveAllWatchlistTVShow saveAllWatchlistTvShow;
  late TvShowRepoMock tVShowRepositoryMock;

  setUp(() {
    tVShowRepositoryMock = TvShowRepoMock();
    saveAllWatchlistTvShow = SaveAllWatchlistTVShow(tVShowRepositoryMock);
  });

  test('should save tv show to the repository', () async {
    // arrange
    when(tVShowRepositoryMock.saveWatchlistTvShow(testTVShowDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final theresult = await saveAllWatchlistTvShow.execute(testTVShowDetail);
    // assert
    verify(tVShowRepositoryMock.saveWatchlistTvShow(testTVShowDetail));
    expect(theresult, Right('Added to Watchlist'));
  });
}
