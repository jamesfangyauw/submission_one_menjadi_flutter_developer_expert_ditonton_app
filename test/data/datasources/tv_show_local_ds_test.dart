import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/excepDb.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/datasources/tv_local_ds.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_tv_show.mocks.dart';

void main() {
  late TVLocalDataSourceImpl tvShowLocalDataSourceImpl;
  late DBHelperMock tvShowDBHelperMock;

  setUp(() {
    tvShowDBHelperMock = DBHelperMock();
    tvShowLocalDataSourceImpl = TVLocalDataSourceImpl(dbHelper: tvShowDBHelperMock);
  });

  group('save watchlist tv show', () {
    test('should return success message when add tv show to database is success',
        () async {
      // arrange
      when(tvShowDBHelperMock.addWatchlistTVShow(testTVShowTable))
          .thenAnswer((_) async => 1);
      // act
      final theresult = await tvShowLocalDataSourceImpl.addWatchlistTVShow(testTVShowTable);
      // assert
      expect(theresult, 'Added to Watchlist');
    });

    test('should throw DatabaseException when add tv show to database is failed',
        () async {
      // arrange
      when(tvShowDBHelperMock.addWatchlistTVShow(testTVShowTable))
          .thenThrow(Exception());
      // act
      final mssgcall = tvShowLocalDataSourceImpl.addWatchlistTVShow(testTVShowTable);
      // assert
      expect(() => mssgcall, throwsA(isA<ExcepDB>()));
    });
  });

  group('delete watchlist tv show', () {
    test('should return success message when delete tv show from database is success',
        () async {
      // arrange
      when(tvShowDBHelperMock.deleteWatchlistTVShow(testTVShowTable))
          .thenAnswer((_) async => 1);
      // act
      final theresult = await tvShowLocalDataSourceImpl.deleteWatchlistTVShow(testTVShowTable);
      // assert
      expect(theresult, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when delete tv show from database is failed',
        () async {
      // arrange
      when(tvShowDBHelperMock.deleteWatchlistTVShow(testTVShowTable))
          .thenThrow(Exception());
      // act
      final mssgcall = tvShowLocalDataSourceImpl.deleteWatchlistTVShow(testTVShowTable);
      // assert
      expect(() => mssgcall, throwsA(isA<ExcepDB>()));
    });
  });

  group('Get TV Show Detail By IdTv', () {
    final tvShowId = 1;

    test('should return TV Show Detail Table when data is found', () async {
      // arrange
      when(tvShowDBHelperMock.getTVShowId(tvShowId))
          .thenAnswer((_) async => testTVShowMap);
      // act
      final theresult = await tvShowLocalDataSourceImpl.getTVShowId(tvShowId);
      // assert
      expect(theresult, testTVShowTable);
    });

    test('should return null when data tv show is not found', () async {
      // arrange
      when(tvShowDBHelperMock.getTVShowId(tvShowId)).thenAnswer((_) async => null);
      // act
      final theresult = await tvShowLocalDataSourceImpl.getTVShowId(tvShowId);
      // assert
      expect(theresult, null);
    });
  });

  group('get watchlist tv show', () {
    test('should return list of TVTable from database', () async {
      // arrange
      when(tvShowDBHelperMock.getWatchlistTVShow())
          .thenAnswer((_) async => [testTVShowMap]);
      // act
      final theresult = await tvShowLocalDataSourceImpl.getWatchlistTVShow();
      // assert
      expect(theresult, [testTVShowTable]);
    });
  });
}
