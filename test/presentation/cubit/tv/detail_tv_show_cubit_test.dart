import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_tv_show_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_watchlist_tv_show_status.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/remove_all_watchlist_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/save_all_watchlist_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/detail_tv_show_cubit.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'detail_tv_show_cubit_test.mocks.dart';



@GenerateMocks([
  GetAllTVShowDetail,
  GetAllWatchListStatusTVShow,
  SaveAllWatchlistTVShow,
  RemoveAllWatchlistTVShow,
])
void main() {
  late MockGetAllTVShowDetail mockGetTVShowDetail;
  late MockGetAllWatchListStatusTVShow mockGetAllWatchListStatusTVShow;
  late MockSaveAllWatchlistTVShow mockSaveAllWatchlistTVShow;
  late MockRemoveAllWatchlistTVShow mockRemoveAllWatchlistTVShow;
  late DetailTVShowCubit detailTVShowCubit;
  setUp(() {
    mockGetTVShowDetail = MockGetAllTVShowDetail();
    mockGetAllWatchListStatusTVShow = MockGetAllWatchListStatusTVShow();
    mockSaveAllWatchlistTVShow = MockSaveAllWatchlistTVShow();
    mockRemoveAllWatchlistTVShow = MockRemoveAllWatchlistTVShow();
    detailTVShowCubit = DetailTVShowCubit(
      getAllTVShowDetail: mockGetTVShowDetail,
      saveAllTVShowWatchlist: mockSaveAllWatchlistTVShow,
      removeAllTVShowWatchlist: mockRemoveAllWatchlistTVShow,
      getAllWatchListTVShowStatus: mockGetAllWatchListStatusTVShow
    );
  });

  tearDown(() async {
    await detailTVShowCubit.close();
  });

  const tvShowId = 1;

  group(
    'TV Show Detail',
        () {
      test('enum state request should be DataLoading when first call', () async {
        /// arrange
        when(mockGetTVShowDetail.execute(tvShowId)).thenAnswer((_) async =>  Right(testTVShowDetail));

        /// act
        detailTVShowCubit.fetchDetailTVShowCubit(tvShowId);

        /// assert
        expect(detailTVShowCubit.state.enumStateRequest, EnumStateRequest.DataLoading);
      });

      test(
        'enum state request should be DataLoaded data when successfull',
            () async {
          /// arrange
          when(mockGetTVShowDetail.execute(tvShowId))
              .thenAnswer((_) async => Right(testTVShowDetail));

          /// act
          await detailTVShowCubit.fetchDetailTVShowCubit(tvShowId);

          /// assert
          expect(detailTVShowCubit.state.tvShowDetail, testTVShowDetail);
        },
      );

      test(
        'enum state request should be DataError when error',
            () async {
          /// arrange
          when(mockGetTVShowDetail.execute(tvShowId))
              .thenAnswer((_) async =>  Left(FailureServer('error')));

          /// act
          await detailTVShowCubit.fetchDetailTVShowCubit(tvShowId);

          /// assert
          expect(detailTVShowCubit.state.enumStateRequest, EnumStateRequest.DataError);
        },
      );
    },
  );

  group(
    'TV Show Detail Watchlist',
        () {
      test('should get watchlist tv show status when function called', () async {
        /// arrange
        when(mockGetAllWatchListStatusTVShow.execute(tvShowId)).thenAnswer((_) async => true);

        /// act
        await detailTVShowCubit.getWatchlistStatusTVShow(tvShowId);

        /// assert
        expect(detailTVShowCubit.state.addWathclistIs, true);
      });

      test(
        'should execute save watchlist tv show when function called',
            () async {
          /// arrange
          when(mockSaveAllWatchlistTVShow.execute(testTVShowDetail))
              .thenAnswer((_) async => const Right('success insert'));
          when(mockGetAllWatchListStatusTVShow.execute(testTVShowDetail.tvShowId)).thenAnswer((_) async => true);

          /// act
          await detailTVShowCubit.addWatchlistTVShow(testTVShowDetail);

          /// assert
          expect(detailTVShowCubit.state.mssgWatchlist, 'success insert');
          verify(mockSaveAllWatchlistTVShow.execute(testTVShowDetail));
        },
      );

      test(
        'should update message watchlist tv show when save function not successfull',
            () async {
          /// arrange
          when(mockSaveAllWatchlistTVShow.execute(testTVShowDetail))
              .thenAnswer((_) async => Left(FailureDB('error')));
          when(mockGetAllWatchListStatusTVShow.execute(testTVShowDetail.tvShowId)).thenAnswer((_) async => true);

          /// act
          await detailTVShowCubit.addWatchlistTVShow(testTVShowDetail);

          /// assert
          expect(detailTVShowCubit.state.mssgWatchlist, 'error');
        },
      );

      test(
        'should execute save watchlist tv show when function called',
            () async {
          /// arrange
          when(mockRemoveAllWatchlistTVShow.execute(testTVShowDetail))
              .thenAnswer((_) async => const Right('success remove'));
          when(mockGetAllWatchListStatusTVShow.execute(testTVShowDetail.tvShowId)).thenAnswer((_) async => true);

          /// act
          await detailTVShowCubit.removeWatchlistTVShow(testTVShowDetail);

          /// assert
          expect(detailTVShowCubit.state.mssgWatchlist, 'success remove');
          verify(mockRemoveAllWatchlistTVShow.execute(testTVShowDetail));
        },
      );

      test(
        'should update message watchlist tv show when remove function not success',
            () async {
          /// arrange
          when(mockRemoveAllWatchlistTVShow.execute(testTVShowDetail))
              .thenAnswer((_) async =>  Left(FailureDB('error')));
          when(mockGetAllWatchListStatusTVShow.execute(testTVShowDetail.tvShowId)).thenAnswer((_) async => true);

          /// act
          await detailTVShowCubit.removeWatchlistTVShow(testTVShowDetail);

          /// assert
          expect(detailTVShowCubit.state.mssgWatchlist, 'error');
        },
      );
    },
  );
}
