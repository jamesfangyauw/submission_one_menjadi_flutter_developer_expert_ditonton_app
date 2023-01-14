import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_watchlist_movies.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_watchlist_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import 'all_the_movie_watchlist_cubit_test.mocks.dart';

@GenerateMocks([GetAllWatchlistMovies])
void main() {
  late MockGetAllWatchlistMovies mockGetAllWatchlistMovies;
  late AllTheMovieWatchlistCubit allTheMovieWatchlistCubit;
  setUp(() {
    mockGetAllWatchlistMovies = MockGetAllWatchlistMovies();
    allTheMovieWatchlistCubit = AllTheMovieWatchlistCubit(getWatchlistAllTheMovies: mockGetAllWatchlistMovies);
  });

  tearDown(() async {
    await allTheMovieWatchlistCubit.close();
  });

  group(
    'All The Movie Watchlist',
    () {
      blocTest<AllTheMovieWatchlistCubit, AllTheMovieWatchlistState>(
        'Should emitsInOrder [DataLoading, DataLoaded] when successfull',
        build: () {
          when(mockGetAllWatchlistMovies.execute())
              .thenAnswer((realInvocation) async => Right(testTheMovieList));
          return allTheMovieWatchlistCubit;
        },
        act: (blocAct) => blocAct.fetchAllTheMovieWatchlistCubit(),
        expect: () => [
          const AllTheMovieWatchlistLoadingState(),
          AllTheMovieWatchlistLoadedState(movies: testTheMovieList),
        ],
      );

      blocTest<AllTheMovieWatchlistCubit, AllTheMovieWatchlistState>(
        'Should emitsInOrder [DataLoading, DataError] when error',
        build: () {
          when(mockGetAllWatchlistMovies.execute())
              .thenAnswer((realInvocation) async =>  Left(FailureServer('error')));
          return allTheMovieWatchlistCubit;
        },
        act: (blocAct) => blocAct.fetchAllTheMovieWatchlistCubit(),
        expect: () => [
          const AllTheMovieWatchlistLoadingState(),
          const AllTheMovieWatchlistErrorState('error'),
        ],
      );
    },
  );
}
