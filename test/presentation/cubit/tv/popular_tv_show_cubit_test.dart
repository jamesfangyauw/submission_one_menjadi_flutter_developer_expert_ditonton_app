import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_popular_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/popular_tv_show_cubit.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_tv_show_cubit_test.mocks.dart';


@GenerateMocks([
  GetAllPopularTVShow,
])
void main() {
  late MockGetAllPopularTVShow mockGetAllPopularTVShow;
  late PopularTVShowCubit popularTVShowCubit;

  setUp(() {
    mockGetAllPopularTVShow = MockGetAllPopularTVShow();
    popularTVShowCubit = PopularTVShowCubit(getAllPopularTVShow: mockGetAllPopularTVShow);
  });

  tearDown(() async {
    await popularTVShowCubit.close();
  });

  group(
    'TV Show Popular',
    () {
      blocTest<PopularTVShowCubit, PopularTVShowState>(
        'Should emitsInOrder [DataLoading, DataLoaded] when successfull',
        build: () {
          when(mockGetAllPopularTVShow.execute()).thenAnswer((_) async => Right(testAllTVShowList));
          return popularTVShowCubit;
        },
        act: (blocAct) => blocAct.fetchPopularTVShowCubit(),
        expect: () => [
          const PopularTVShowLoadingState(),
          PopularTVShowLoadedState(tvShow: testAllTVShowList),
        ],
      );

      blocTest<PopularTVShowCubit, PopularTVShowState>(
        'Should emitsInOrder [DataLoading, DataLoaded] when error',
        build: () {
          when(mockGetAllPopularTVShow.execute())
              .thenAnswer((_) async =>  Left(FailureServer('error')));
          return popularTVShowCubit;
        },
        act: (blocAct) => blocAct.fetchPopularTVShowCubit(),
        expect: () => [
          const PopularTVShowLoadingState(),
          const PopularTVShowErrorState('error'),
        ],
      );
    },
  );
}
