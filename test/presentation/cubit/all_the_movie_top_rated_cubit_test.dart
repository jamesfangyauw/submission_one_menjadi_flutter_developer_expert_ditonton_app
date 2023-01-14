import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_top_rated_movies.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_top_rated_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'all_the_movie_top_rated_cubit_test.mocks.dart';


@GenerateMocks([GetAllTopRatedMovies])
void main() {
  late MockGetAllTopRatedMovies mockGetAllTopRatedMovies;
  late AllTheMovieTopRatedCubit allTheMovieTopRatedCubit;
  setUp(
    () {
      mockGetAllTopRatedMovies = MockGetAllTopRatedMovies();
      allTheMovieTopRatedCubit = AllTheMovieTopRatedCubit(getTopRatedAllTheMovies: mockGetAllTopRatedMovies);
    },
  );

  tearDown(() async {
    await allTheMovieTopRatedCubit.close();
  });

  group(
    'All The Movie Top Rated',
    () {
      blocTest<AllTheMovieTopRatedCubit, AllTheMovieTopRatedState>(
        'Should emitsInOrder [DataLoading, DataLoaded] when successfull',
        build: () {
          when(mockGetAllTopRatedMovies.execute()).thenAnswer((_) async => Right(testTheMovieList));
          return allTheMovieTopRatedCubit;
        },
        act: (blocAct) => blocAct.fetchAllTheMovieTopRatedCubit(),
        expect: () => [
          const AllTheMovieTopRatedLoadingState(),
          AllTheMovieTopRatedLoadedState(movies: testTheMovieList),
        ],
      );

      blocTest<AllTheMovieTopRatedCubit, AllTheMovieTopRatedState>(
        'Should emitsInOrder [DataLoading, DataError] when error',
        build: () {
          when(mockGetAllTopRatedMovies.execute())
              .thenAnswer((_) async =>  Left(FailureServer('error')));
          return allTheMovieTopRatedCubit;
        },
        act: (blocAct) => blocAct.fetchAllTheMovieTopRatedCubit(),
        expect: () => [
          const AllTheMovieTopRatedLoadingState(),
          const AllTheMovieTopRatedErrorState('error'),
        ],
      );
    },
  );
}
