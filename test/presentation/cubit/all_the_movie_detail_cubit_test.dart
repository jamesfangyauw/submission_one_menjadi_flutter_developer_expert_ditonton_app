import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_movie_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_watchlist_status.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/remove_all_watchlist.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/save_all_watchlist.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_details_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'all_the_movie_detail_cubit_test.mocks.dart';

@GenerateMocks([
  GetAllMovieDetail,
  GetAllWatchListTheMoviesStatus,
  SaveAllWatchListTheMovies,
  RemoveAllWatchlistTheMovies,
])
void main() {
  late MockGetAllMovieDetail mockGetAllMovieDetail;
  late MockGetAllWatchListTheMoviesStatus mockGetAllWatchListTheMoviesStatus;
  late MockSaveAllWatchListTheMovies mockSaveAllWatchListTheMovies;
  late MockRemoveAllWatchlistTheMovies mockRemoveAllWatchlistTheMovies;
  late AllTheMovieDetailCubit allTheMovieDetailCubit;
  setUp(() {
    mockGetAllMovieDetail = MockGetAllMovieDetail();
    mockGetAllWatchListTheMoviesStatus = MockGetAllWatchListTheMoviesStatus();
    mockSaveAllWatchListTheMovies = MockSaveAllWatchListTheMovies();
    mockRemoveAllWatchlistTheMovies = MockRemoveAllWatchlistTheMovies();
    allTheMovieDetailCubit = AllTheMovieDetailCubit(
      getAllTheMovieDetail: mockGetAllMovieDetail,
      saveAllWatchlistTheMovies: mockSaveAllWatchListTheMovies,
      removeAllWatchlistTheMovies: mockRemoveAllWatchlistTheMovies,
      getAllWatchListTheMoviesStatus: mockGetAllWatchListTheMoviesStatus,
    );
  });

  tearDown(() async {
    await allTheMovieDetailCubit.close();
  });

  const id = 1;

  group(
    'All The Movie Detail',
        () {
      test('enumstaterequest should be DataLoading when first call', () async {
        /// arrange
        when(mockGetAllMovieDetail.execute(id)).thenAnswer((_) async =>  Right(testTheMovieDetail));

        /// act
        allTheMovieDetailCubit.fetchAllTheMoviesDetailsCubit(id);

        /// assert
        expect(allTheMovieDetailCubit.state.enumStateRequest, EnumStateRequest.DataLoading);
      });

      test(
        'enumstaterequest should be DataLoaded data when successfull',
            () async {
          /// arrange
          when(mockGetAllMovieDetail.execute(id))
              .thenAnswer((_) async => Right(testTheMovieDetail));

          /// act
          await allTheMovieDetailCubit.fetchAllTheMoviesDetailsCubit(id);

          /// assert
          expect(allTheMovieDetailCubit.state.movieDetail, testTheMovieDetail);
        },
      );

      test(
        'enumstaterequest should be DataError when error',
            () async {
          /// arrange
          when(mockGetAllMovieDetail.execute(id))
              .thenAnswer((_) async =>  Left(FailureServer('error')));

          /// act
          await allTheMovieDetailCubit.fetchAllTheMoviesDetailsCubit(id);

          /// assert
          expect(allTheMovieDetailCubit.state.enumStateRequest, EnumStateRequest.DataError);
        },
      );
    },
  );

  group(
    'All The Movie Detail Watchlist',
        () {
      test('should get watchlist all the movie status when function called', () async {
        /// arrange
        when(mockGetAllWatchListTheMoviesStatus.execute(id)).thenAnswer((_) async => true);

        /// act
        await allTheMovieDetailCubit.getWatchlistStatus(id);

        /// assert
        expect(allTheMovieDetailCubit.state.addToWatchlistIs, true);
      });

      test(
        'should execute save watchlist all the movie when function called',
            () async {
          /// arrange
          when(mockSaveAllWatchListTheMovies.execute(testTheMovieDetail))
              .thenAnswer((_) async => const Right('success insert'));
          when(mockGetAllWatchListTheMoviesStatus.execute(testTheMovieDetail.idMovie)).thenAnswer((_) async => true);

          /// act
          await allTheMovieDetailCubit.addWatchlistTheMovies(testTheMovieDetail);

          /// assert
          expect(allTheMovieDetailCubit.state.mssgWatchlist, 'success insert');
          verify(mockSaveAllWatchListTheMovies.execute(testTheMovieDetail));
        },
      );

      test(
        'should update message watchlist all the movie when save function error',
            () async {
          /// arrange
          when(mockSaveAllWatchListTheMovies.execute(testTheMovieDetail))
              .thenAnswer((_) async => Left(FailureDB('error')));
          when(mockGetAllWatchListTheMoviesStatus.execute(testTheMovieDetail.idMovie)).thenAnswer((_) async => true);

          /// act
          await allTheMovieDetailCubit.addWatchlistTheMovies(testTheMovieDetail);

          /// assert
          expect(allTheMovieDetailCubit.state.mssgWatchlist, 'error');
        },
      );

      test(
        'should execute save watchlist all the movie when function called',
            () async {
          /// arrange
          when(mockRemoveAllWatchlistTheMovies.execute(testTheMovieDetail))
              .thenAnswer((_) async => const Right('success remove'));
          when(mockGetAllWatchListTheMoviesStatus.execute(testTheMovieDetail.idMovie)).thenAnswer((_) async => true);

          /// act
          await allTheMovieDetailCubit.deleteWatchlistTheMovies(testTheMovieDetail);

          /// assert
          expect(allTheMovieDetailCubit.state.mssgWatchlist, 'success remove');
          verify(mockRemoveAllWatchlistTheMovies.execute(testTheMovieDetail));
        },
      );

      test(
        'should update message watchlist all the movie when remove function error',
            () async {
          /// arrange
          when(mockRemoveAllWatchlistTheMovies.execute(testTheMovieDetail))
              .thenAnswer((_) async =>  Left(FailureDB('error')));
          when(mockGetAllWatchListTheMoviesStatus.execute(testTheMovieDetail.idMovie)).thenAnswer((_) async => true);

          /// act
          await allTheMovieDetailCubit.deleteWatchlistTheMovies(testTheMovieDetail);

          /// assert
          expect(allTheMovieDetailCubit.state.mssgWatchlist, 'error');
        },
      );
    },
  );
}
