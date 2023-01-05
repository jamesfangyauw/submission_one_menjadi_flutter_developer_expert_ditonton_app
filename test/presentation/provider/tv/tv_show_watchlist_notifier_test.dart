import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_watchlist_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_watchlist_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'tv_show_watchlist_notifier_test.mocks.dart';

@GenerateMocks([GetAllWatchlistTVShow])
void main() {
  late TvShowWatchlistNotifier tvShowWatchlistNotifier;
  late GetWatchlistTVShowMock getWatchlistTVShowMock;
  late int countListenerCall;

  setUp(() {
    countListenerCall = 0;
    getWatchlistTVShowMock = GetWatchlistTVShowMock();
    tvShowWatchlistNotifier = TvShowWatchlistNotifier(
      getAllWatchlistTVShow: getWatchlistTVShowMock,
    )..addListener(() {
        countListenerCall = countListenerCall + 1;
      });
  });

  test('should change tv show data when data is gotten successfully', () async {
    // arrange
    when(getWatchlistTVShowMock.execute())
        .thenAnswer((_) async => Right([testWatchlistAllTVShow]));
    // act
    await tvShowWatchlistNotifier.fetchWatchlistTVShow();
    // assert
    expect(tvShowWatchlistNotifier.tvShowwatchlistState, EnumStateRequest.DataLoaded);
    expect(tvShowWatchlistNotifier.tvShowWatchlist, [testWatchlistAllTVShow]);
    expect(countListenerCall, 2);
  });

  test('should return error when data is not successful', () async {
    // arrange
    when(getWatchlistTVShowMock.execute())
        .thenAnswer((_) async => Left(FailureDB("Can't get data")));
    // act
    await tvShowWatchlistNotifier.fetchWatchlistTVShow();
    // assert
    expect(tvShowWatchlistNotifier.tvShowwatchlistState, EnumStateRequest.DataError);
    expect(tvShowWatchlistNotifier.mssg, "Can't get data");
    expect(countListenerCall, 2);
  });
}
