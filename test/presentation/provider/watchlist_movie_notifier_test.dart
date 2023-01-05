import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_watchlist_movies.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/watchlist_movie_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_notifier_test.mocks.dart';

@GenerateMocks([GetAllWatchlistMovies])
void main() {
  late WatchlistMovieNotifier watchlistMovieNotifier;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late int countListenerCall;

  setUp(() {
    countListenerCall = 0;
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieNotifier = WatchlistMovieNotifier(
      getWatchlistMovies: mockGetWatchlistMovies,
    )..addListener(() {
        countListenerCall = countListenerCall+ 1;
      });
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlistMovies.execute())
        .thenAnswer((_) async => Right([testWatchlistAllMovie]));
    // act
    await watchlistMovieNotifier.fetchWatchlistMovies();
    // assert
    expect(watchlistMovieNotifier.watchlistState, EnumStateRequest.DataLoaded);
    expect(watchlistMovieNotifier.watchlistMovies, [testWatchlistAllMovie]);
    expect(countListenerCall, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistMovies.execute())
        .thenAnswer((_) async => Left(FailureDB("Can't get data")));
    // act
    await watchlistMovieNotifier.fetchWatchlistMovies();
    // assert
    expect(watchlistMovieNotifier.watchlistState, EnumStateRequest.DataError);
    expect(watchlistMovieNotifier.message, "Can't get data");
    expect(countListenerCall, 2);
  });
}
