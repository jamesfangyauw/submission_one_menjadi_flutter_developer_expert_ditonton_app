import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_movie_recommendations.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_recommendations_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'all_the_movie_recommendations_cubit_test.mocks.dart';

@GenerateMocks([GetAllMovieRecommendations])
void main() {
  late MockGetAllMovieRecommendations mockGetAllMovieRecommendations;
  late AllTheMovieRecommendationsCubit allTheMovieRecommendationsCubit;

  setUp(() {
    mockGetAllMovieRecommendations = MockGetAllMovieRecommendations();
    allTheMovieRecommendationsCubit = AllTheMovieRecommendationsCubit(
      getAllTheMovieRecommendations: mockGetAllMovieRecommendations,
    );
  });

  tearDown(() async {
    await allTheMovieRecommendationsCubit.close();
  });

  const testMovieId = 1;
  final testMovie = Movie(
    adultMovie: false,
    backdropPathMovie: 'pathBackropMovie',
    genreIdsMovie: const [1, 2, 3],
    idMovie: 1,
    originalTitleMovie: 'originalTitleMovie',
    overviewMovie: 'movieOverview',
    popularityMovie: 1,
    posterPathMovie: 'moviePosterPath',
    releaseDateMovie: 'movieReleaseDate',
    titleMovie: 'titleMovie',
    videoMovie: false,
    voteAverageMovie: 1,
    voteCountMovie: 1,
  );
  final testAllTheMovies = <Movie>[testMovie];
  group(
    'All The Movie Recommendations',
    () {
      blocTest<AllTheMovieRecommendationsCubit, AllTheMovieRecommendationsState>(
        'Should emitsInOrder [DataLoading, DataLoaded] when success',
        build: () {
          when(mockGetAllMovieRecommendations.execute(testMovieId)).thenAnswer((_) async => Right(testAllTheMovies));
          return allTheMovieRecommendationsCubit;
        },
        act: (blocAct) => blocAct.fetchAllTheMovieRecommendationsCubit(testMovieId),
        expect: () => [
          const AllTheMovieRecommendationsLoadingState(),
          AllTheMovieRecommendationsLoadedState(movies: testAllTheMovies),
        ],
      );

      blocTest<AllTheMovieRecommendationsCubit, AllTheMovieRecommendationsState>(
        'Should emitsInOrder [DataLoading, DataError] when error',
        build: () {
          when(mockGetAllMovieRecommendations.execute(testMovieId))
              .thenAnswer((_) async =>  Left(FailureServer('error')));
          return allTheMovieRecommendationsCubit;
        },
        act: (blocAct) => blocAct.fetchAllTheMovieRecommendationsCubit(testMovieId),
        expect: () => [
          const AllTheMovieRecommendationsLoadingState(),
          const AllTheMovieRecommendationsErrorState('error'),
        ],
      );
    },
  );
}
