import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_top_rated_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/top_rated_tv_show_cubit.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_show_cubit_test.mocks.dart';


@GenerateMocks([GetTopRatedTVShow])
void main() {
  late MockGetTopRatedTVShow mockGetTopRatedTVShow;
  late TopRatedTVShowCubit topRatedTVShowCubit;
  setUp(
    () {
      mockGetTopRatedTVShow = MockGetTopRatedTVShow();
      topRatedTVShowCubit = TopRatedTVShowCubit(getTopRatedTVShow: mockGetTopRatedTVShow);
    },
  );

  tearDown(() async {
    await topRatedTVShowCubit.close();
  });

  group(
    'TV Show Top Rated',
    () {
      blocTest<TopRatedTVShowCubit, TopRatedTVShowState>(
        'Should emitsInOrder [DataLoading, DataLoaded] when success',
        build: () {
          when(mockGetTopRatedTVShow.execute()).thenAnswer((_) async => Right(testAllTVShowList));
          return topRatedTVShowCubit;
        },
        act: (blocAct) => blocAct.fetchTopRatedTVShowCubit(),
        expect: () => [
          const TopRatedTVShowLoadingState(),
          TopRatedTVShowLoadedState(tvShow: testAllTVShowList),
        ],
      );

      blocTest<TopRatedTVShowCubit, TopRatedTVShowState>(
        'Should emitsInOrder [DataLoading, DataError] when error',
        build: () {
          when(mockGetTopRatedTVShow.execute())
              .thenAnswer((_) async =>  Left(FailureServer('error')));
          return topRatedTVShowCubit;
        },
        act: (blocAct) => blocAct.fetchTopRatedTVShowCubit(),
        expect: () => [
          const TopRatedTVShowLoadingState(),
          const TopRatedTVShowErrorState('error'),
        ],
      );
    },
  );
}
