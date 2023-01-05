import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_watchlist_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper_tv_show.mocks.dart';

void main() {
  late GetAllWatchlistTVShow getAllWatchListTvShow;
  late TvShowRepoMock tVShowRepositoryMock;

  setUp(() {
    tVShowRepositoryMock = TvShowRepoMock();
    getAllWatchListTvShow = GetAllWatchlistTVShow(tVShowRepositoryMock);
  });

  test('should get list of TV Show from the repository', () async {
    // arrange
    when(tVShowRepositoryMock.getAllWatchlistTvShow())
        .thenAnswer((_) async => Right(testAllTVShowList));
    // act
    final theresult = await getAllWatchListTvShow.execute();
    // assert
    expect(theresult, Right(testAllTVShowList));
  });
}
