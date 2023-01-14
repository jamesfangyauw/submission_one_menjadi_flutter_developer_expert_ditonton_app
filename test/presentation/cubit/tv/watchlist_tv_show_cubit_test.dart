import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_watchlist_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/watchlist_tv_show_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_show_cubit_test.mocks.dart';


@GenerateMocks([GetAllWatchlistTVShow])
void main() {
  late MockGetAllWatchlistTVShow mockGetAllWatchlistTVShow;
  late WatchlistTVShowCubit watchlistTVShowCubit;
  setUp(() {
    mockGetAllWatchlistTVShow = MockGetAllWatchlistTVShow();
    watchlistTVShowCubit = WatchlistTVShowCubit(getAllWatchlistTVShow: mockGetAllWatchlistTVShow);
  });

  tearDown(() async {
    await watchlistTVShowCubit.close();
  });

  group(
    'TV Show Watchlist',
    () {
      blocTest<WatchlistTVShowCubit, WatchlistTVShowState>(
        'Should emitsInOrder [DataLoading, DataLoaded] when successfull',
        build: () {
          when(mockGetAllWatchlistTVShow.execute())
              .thenAnswer((realInvocation) async => Right(testAllTVShowList));
          return watchlistTVShowCubit;
        },
        act: (blocAct) => blocAct.fetchWatchlistTVShowCubit(),
        expect: () => [
          const WatchlistLoadingTVShowState(),
          WatchlistTVShowLoadedState(tvShow: testAllTVShowList),
        ],
      );

      blocTest<WatchlistTVShowCubit, WatchlistTVShowState>(
        'Should emitsInOrder [DataLoading, DataError] when error',
        build: () {
          when(mockGetAllWatchlistTVShow.execute())
              .thenAnswer((realInvocation) async =>  Left(FailureServer('error')));
          return watchlistTVShowCubit;
        },
        act: (blocAct) => blocAct.fetchWatchlistTVShowCubit(),
        expect: () => [
          const WatchlistLoadingTVShowState(),
          const WatchlistTVShowErrorState('error'),
        ],
      );
    },
  );
}
