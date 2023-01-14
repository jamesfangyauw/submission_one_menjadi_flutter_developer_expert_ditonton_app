import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_tv_show_recommendations.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/recommendations_tv_show_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'recommendantions_tv_show_cubit_test.mocks.dart';


@GenerateMocks([GetAllTVShowRecommendations])
void main() {
  late MockGetTVShowRecommendations mockGetTVShowRecommendations;
  late RecommendationsTVShowCubit recommendationsTVShowCubit;

  setUp(() {
    mockGetTVShowRecommendations = MockGetTVShowRecommendations();
    recommendationsTVShowCubit = RecommendationsTVShowCubit(
      getAllTVShowRecommendations: mockGetTVShowRecommendations,
    );
  });

  tearDown(() async {
    await recommendationsTVShowCubit.close();
  });

  const tvShowId = 1;
  final testTV = TVEntities(
    pathBackdrop: 'backdropPath',
    date_first_show : 'date first show',
    genreIdsTv: const [1, 2, 3],
    idTv: 1,
    name_original: 'originalTitle',
    nameTv : 'tv name',
    language_original : 'language original',
    tv_overview: 'overview',
    tv_popularity: 1,
    path_poster: 'posterPath',
    tv_voteAverage : 1,
    tv_voteCount : 1,
  );
  final testTVShow = <TVEntities>[testTV];
  group(
    'TV Show Recommendations',
        () {
      blocTest<RecommendationsTVShowCubit, RecommendationsTVShowState>(
        'Should emitsInOrder [DataLoading, DataLoaded] when successfull',
        build: () {
          when(mockGetTVShowRecommendations.execute(tvShowId)).thenAnswer((_) async => Right(testTVShow));
          return recommendationsTVShowCubit;
        },
        act: (blocAct) => blocAct.fetchRecommendationsTVShowCubit(tvShowId),
        expect: () => [
          const RecommendationsTVShowLoadingState(),
          RecommendationsTVShowLoadedState(items: testTVShow),
        ],
      );

      blocTest<RecommendationsTVShowCubit, RecommendationsTVShowState>(
        'Should emitsInOrder [DataLoading, DataError] when error',
        build: () {
          when(mockGetTVShowRecommendations.execute(tvShowId))
              .thenAnswer((_) async =>  Left(FailureServer('error')));
          return recommendationsTVShowCubit;
        },
        act: (blocAct) => blocAct.fetchRecommendationsTVShowCubit(tvShowId),
        expect: () => [
          const RecommendationsTVShowLoadingState(),
          const RecommendationsTVShowErrorState('error'),
        ],
      );
    },
  );
}
