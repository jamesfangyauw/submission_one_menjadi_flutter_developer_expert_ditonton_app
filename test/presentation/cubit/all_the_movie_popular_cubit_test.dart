import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_popular_movies.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_popular_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'all_the_movie_popular_cubit_test.mocks.dart';


@GenerateMocks([GetAllPopularMovies])

void main() {
  late MockGetAllPopularMovies mockGetAllPopularMovies;
  late AllTheMoviePopularCubit allTheMoviePopularCubit;

  setUp(() {
    mockGetAllPopularMovies = MockGetAllPopularMovies();
    allTheMoviePopularCubit = AllTheMoviePopularCubit(getAllThePopularMovies: mockGetAllPopularMovies);
  });

  tearDown(() async {
    await allTheMoviePopularCubit.close();
  });

  group(
    'All The Movie Popular',
    () {
      blocTest<AllTheMoviePopularCubit, AllTheMoviePopularState>(
        'Should emitsInOrder [DataLoading, DataLoaded] when successfull',
        build: () {
          when(mockGetAllPopularMovies.execute()).thenAnswer((_) async => Right(testTheMovieList));
          return allTheMoviePopularCubit;
        },
        act: (blocAct) => blocAct.fetchAllThePopularMovieCubit(),
        expect: () => [
          const AllTheMoviePopularLoadingState(),
          AllTheMoviePopularLoadedState(movies: testTheMovieList),
        ],
      );

      blocTest<AllTheMoviePopularCubit, AllTheMoviePopularState>(
        'Should emitsInOrder [DataLoading, DataLoaded] when error',
        build: () {
          when(mockGetAllPopularMovies.execute())
              .thenAnswer((_) async =>  Left(FailureServer('error')));
          return allTheMoviePopularCubit;
        },
        act: (bloc) => bloc.fetchAllThePopularMovieCubit(),
        expect: () => [
          const AllTheMoviePopularLoadingState(),
          const AllTheMoviePopularErrorState('error'),
        ],
      );
    },
  );
}
