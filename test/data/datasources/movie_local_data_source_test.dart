import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/excepDb.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/datasources/movie_local_ds.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieLocalDSImpl movieLocalDSImpl;
  late MockDBHelper mockDBHelper;

  setUp(() {
    mockDBHelper = MockDBHelper();
    movieLocalDSImpl = MovieLocalDSImpl(dbHelper: mockDBHelper);
  });

  group('save watchlist', () {
    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDBHelper.addWatchlist(testTheMovieTable))
          .thenThrow(Exception());
      // act
      final mssgcall = movieLocalDSImpl.addWatchlist(testTheMovieTable);
      // assert
      expect(() => mssgcall, throwsA(isA<ExcepDB>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDBHelper.deleteWatchlistMovie(testTheMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final theresult = await movieLocalDSImpl.deleteWatchlist(testTheMovieTable);
      // assert
      expect(theresult, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDBHelper.deleteWatchlistMovie(testTheMovieTable))
          .thenThrow(Exception());
      // act
      final mssgcall = movieLocalDSImpl.deleteWatchlist(testTheMovieTable);
      // assert
      expect(() => mssgcall, throwsA(isA<ExcepDB>()));
    });
  });

  group('Get Movie Detail By Id', () {
    final tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDBHelper.getMoviesId(tId))
          .thenAnswer((_) async => testTheMovieMap);
      // act
      final theresult = await movieLocalDSImpl.getMovieId(tId);
      // assert
      expect(theresult, testTheMovieTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDBHelper.getMoviesId(tId)).thenAnswer((_) async => null);
      // act
      final theresult = await movieLocalDSImpl.getMovieId(tId);
      // assert
      expect(theresult, null);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDBHelper.getWatchlistTheMovie())
          .thenAnswer((_) async => [testTheMovieMap]);
      // act
      final theresult = await movieLocalDSImpl.getWatchlistAllMovie();
      // assert
      expect(theresult, [testTheMovieTable]);
    });
  });
}
