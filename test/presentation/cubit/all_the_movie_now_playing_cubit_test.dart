import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_now_playing_movies.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_now_playing_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'all_the_movie_now_playing_cubit_test.mocks.dart';

@GenerateMocks([GetAllNowPlayingMovies])
void main() {
  late MockGetAllNowPlayingMovies mockGetAllNowPlayingMovies;
  late AllTheMovieNowPlayingCubit allTheMovieNowPlayingCubit;

  setUp(() {
    mockGetAllNowPlayingMovies = MockGetAllNowPlayingMovies();
    allTheMovieNowPlayingCubit = AllTheMovieNowPlayingCubit(
      getNowPlayingAllTheMovies: mockGetAllNowPlayingMovies,
    );
  });

  tearDown(() async {
    await allTheMovieNowPlayingCubit.close();
  });

  group(
    'All The Movie Now Playing',
    () {
      blocTest<AllTheMovieNowPlayingCubit, AllTheMovieNowPlayingState>(
        'should emitsInOrder [DataLoading, DataLoaded] when successfull',
        build: () {
          when(mockGetAllNowPlayingMovies.execute()).thenAnswer((_) async => Right(testTheMovieList));
          return allTheMovieNowPlayingCubit;
        },
        act: (blocAct) => blocAct.fetchAllTheMovieNowPlayingCubit(),
        expect: () => [
          const AllTheMovieNowPlayingLoadingState(),
          AllTheMovieNowPlayingLoadedState(movies: testTheMovieList),
        ],
      );

      blocTest<AllTheMovieNowPlayingCubit, AllTheMovieNowPlayingState>(
        'should emitsInOrder [DataLoading, DataError] when error',
        build: () {
          when(mockGetAllNowPlayingMovies.execute())
              .thenAnswer((_) async =>  Left(FailureServer('error')));
          return allTheMovieNowPlayingCubit;
        },
        act: (bloc) => bloc.fetchAllTheMovieNowPlayingCubit(),
        expect: () => [
          const AllTheMovieNowPlayingLoadingState(),
          const AllTheMovieNowPlayingErrorState('error'),
        ],
      );
    },
  );
}
