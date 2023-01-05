import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_watchlist_status.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_watchlist_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_watchlist_tv_show_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper_tv_show.mocks.dart';
void main() {
  late GetAllWatchListStatusTVShow getAllWatchListTvShowStatus;
  late TvShowRepoMock tVShowRepoMock;

  setUp(() {
    tVShowRepoMock = TvShowRepoMock();
    getAllWatchListTvShowStatus = GetAllWatchListStatusTVShow(tVShowRepoMock);
  });

  test('should get watchlist tv show status from repository', () async {
    // arrange
    when(tVShowRepoMock.isAddedToWatchlistTvShow(1))
        .thenAnswer((_) async => true);
    // act
    final therslt =await getAllWatchListTvShowStatus.execute(1);
    // assert
    expect(therslt, true);
  });
}
