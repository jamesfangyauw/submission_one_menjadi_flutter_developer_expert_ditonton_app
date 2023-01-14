import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_now_playing_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/now_playing_tv_show_cubit.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'now_playing_tv_show_cubit_test.mocks.dart';


@GenerateMocks([GetAllNowPlayingTVShow])
void main() {
  late MockGetAllNowPlayingTVShow mockGetAllNowPlayingTVShow;
  late NowPlayingTVShowCubit nowPlayingTVShowCubit;

  setUp(() {
    mockGetAllNowPlayingTVShow = MockGetAllNowPlayingTVShow();
    nowPlayingTVShowCubit = NowPlayingTVShowCubit(
      getAllNowPlayingTVShow: mockGetAllNowPlayingTVShow,
    );
  });

  tearDown(() async {
    await nowPlayingTVShowCubit.close();
  });

  group(
    'TV Show Now Playing',
    () {
      blocTest<NowPlayingTVShowCubit, NowPlayingTVShowState>(
        'should emitsInOrder [DataLoading, DataLoaded] when successfull',
        build: () {
          when(mockGetAllNowPlayingTVShow.execute()).thenAnswer((_) async => Right(testAllTVShowList));
          return nowPlayingTVShowCubit;
        },
        act: (blocAct) => blocAct.fetchNowPlayingTVShowCubit(),
        expect: () => [
          const NowPlayingTVShowLoadingState(),
          NowPlayingTVShowLoadedState(tvShow: testAllTVShowList),
        ],
      );

      blocTest<NowPlayingTVShowCubit, NowPlayingTVShowState>(
        'should emitsInOrder [DataLoading, DataError] when is error',
        build: () {
          when(mockGetAllNowPlayingTVShow.execute())
              .thenAnswer((_) async =>  Left(FailureServer('error')));
          return nowPlayingTVShowCubit;
        },
        act: (blocAct) => blocAct.fetchNowPlayingTVShowCubit(),
        expect: () => [
          const NowPlayingTVShowLoadingState(),
          const NowPlayingTVShowErrorState('error'),
        ],
      );
    },
  );
}
