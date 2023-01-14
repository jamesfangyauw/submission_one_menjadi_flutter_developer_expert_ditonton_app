import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_genre.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_tv_show_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/repositories/tvshow_repo_impl.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/excepDb.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_tv_show.mocks.dart';

void main() {
  late TVShowRepoImpl mockTvShowRepoImpl;
  late MockTVRemoteDS mockTvShowRemoteDataSource;
  late MockTVLocalDS mockTvShowLocalDataSource;

  setUp(() {
    mockTvShowRemoteDataSource = MockTVRemoteDS();
    mockTvShowLocalDataSource = MockTVLocalDS();
    mockTvShowRepoImpl = TVShowRepoImpl(
      tvRemoteDS: mockTvShowRemoteDataSource,
      tvLocalDS: mockTvShowLocalDataSource,
    );
  });

  final testShowTVModel = ModelTVShow(
    pathBackdrop: '/jwIsjeLsleqpaQqwIOWjsleqo34jaiw12Jal34124Jw.jpg',
    genreIdTv: [31, 24, 19, 21],
    idTv: 669,
    name_origin: 'Wednesday',
    overview_tv:
        'Wednesday Addams is expelled from her school after dumping live piranhas into the school\'s pool in retaliation for the boys\' water polo team bullying her brother, Pugsley. Consequently, her parents, Gomez and Morticia Addams, enroll her at their high school alma mater, Nevermore Academy, in the town of Jericho, Vermont, a private school for monstrous outcasts. Wednesday\'s cold, emotionless personality and her defiant nature make it difficult for her to connect with her schoolmates and cause her to run afoul of the school\'s principal. However, she discovers she has inherited her mother\'s psychic abilities which allow her to solve a local murder mystery.',
    tv_popularity: 95.555,
    path_poster: '/wEjweOwjslO12aj393.jpg',
    date_first_show: '2022-09-21',
    nameTv: 'Wednesday',
    language_origin: 'EN',
    average_vote: 8.9,
    count_vote: 24312,
  );

  final testTVShow = TVEntities(
    pathBackdrop: '/jwIsjeLsleqpaQqwIOWjsleqo34jaiw12Jal34124Jw.jpg',
    genreIdsTv: [31, 24, 19, 21],
    idTv: 669,
    name_original: 'Wednesday',
    tv_overview:
    'Wednesday Addams is expelled from her school after dumping live piranhas into the school\'s pool in retaliation for the boys\' water polo team bullying her brother, Pugsley. Consequently, her parents, Gomez and Morticia Addams, enroll her at their high school alma mater, Nevermore Academy, in the town of Jericho, Vermont, a private school for monstrous outcasts. Wednesday\'s cold, emotionless personality and her defiant nature make it difficult for her to connect with her schoolmates and cause her to run afoul of the school\'s principal. However, she discovers she has inherited her mother\'s psychic abilities which allow her to solve a local murder mystery.',
    tv_popularity: 95.555,
    path_poster: '/wEjweOwjslO12aj393.jpg',
    date_first_show: '2022-09-21',
    nameTv: 'Wednesday',
    language_original: 'EN',
    tv_voteAverage: 8.9,
    tv_voteCount: 24312,
  );

  final testTVShowModelList = <ModelTVShow>[testShowTVModel];
  final testTVShowList = <TVEntities>[testTVShow];

  group('Now Playing TV Show', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getNowPlayingTVShow())
          .thenAnswer((_) async => testTVShowModelList);
      // act
      final theresult = await mockTvShowRepoImpl.getNowPlayingAllTVShow();
      // assert
      verify(mockTvShowRemoteDataSource.getNowPlayingTVShow());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final tvshowresultList = theresult.getOrElse(() => []);
      expect(tvshowresultList, testTVShowList);
    });

    test(
        'should return server failure when the call to remote data source is not successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getNowPlayingTVShow()).thenThrow(ExceptServer());
      // act
      final theresult = await mockTvShowRepoImpl.getNowPlayingAllTVShow();
      // assert
      verify(mockTvShowRemoteDataSource.getNowPlayingTVShow());
      expect(theresult, equals(Left(FailureServer(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getNowPlayingTVShow())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final theresult = await mockTvShowRepoImpl.getNowPlayingAllTVShow();
      // assert
      verify(mockTvShowRemoteDataSource.getNowPlayingTVShow());
      expect(theresult,
          equals(Left(FailureConnection('Failed to connect to the network'))));
    });
    test(
        'should return Certification Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvShowRemoteDataSource.getNowPlayingTVShow())
              .thenThrow(TlsException());
          // act
          final theresult = await mockTvShowRepoImpl.getNowPlayingAllTVShow();
          // assert
          verify(mockTvShowRemoteDataSource.getNowPlayingTVShow());
          expect(theresult, equals(Left(FailureCommon('Certificated is not valid\n'))));
        });
  });

  group('Popular TV Show', () {
    test('should return all tv show list when call to data source is success', () async {
      // arrange
      when(mockTvShowRemoteDataSource.getPopularTVShow())
          .thenAnswer((_) async => testTVShowModelList);
      // act
      final theresult = await mockTvShowRepoImpl.getPopularAllTVShow();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final tvshowresultList = theresult.getOrElse(() => []);
      expect(tvshowresultList, testTVShowList);
    });

    test(
        'should return server failure when call to data source is not successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getPopularTVShow()).thenThrow(ExceptServer());
      // act
      final theresult = await mockTvShowRepoImpl.getPopularAllTVShow();
      // assert
      expect(theresult, Left(FailureServer('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getPopularTVShow())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final theresult = await mockTvShowRepoImpl.getPopularAllTVShow();
      // assert
      expect(
          theresult, Left(FailureConnection('Failed to connect to the network')));
    });
    test(
        'should return Certification Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvShowRemoteDataSource.getPopularTVShow())
              .thenThrow(TlsException());
          // act
          final theresult = await mockTvShowRepoImpl.getPopularAllTVShow();
          // assert
          verify(mockTvShowRemoteDataSource.getPopularTVShow());
          expect(theresult, equals(Left(FailureCommon('Certificated is not valid\n'))));
        });
  });

  group('Top Rated TV Show', () {
    test('should return tv list when call to data source is successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTopRatedTVShow())
          .thenAnswer((_) async => testTVShowModelList);
      // act
      final theresult = await mockTvShowRepoImpl.getAllTopRatedTVShow();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final tvshowresultList = theresult.getOrElse(() => []);
      expect(tvshowresultList, testTVShowList);
    });

    test('should return ServerFailure when call to data source is not successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTopRatedTVShow()).thenThrow(ExceptServer());
      // act
      final theresult = await mockTvShowRepoImpl.getAllTopRatedTVShow();
      // assert
      expect(theresult, Left(FailureServer('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTopRatedTVShow())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final theresult = await mockTvShowRepoImpl.getAllTopRatedTVShow();
      // assert
      expect(
          theresult, Left(FailureConnection('Failed to connect to the network')));
    });
    test(
        'should return Certification Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvShowRemoteDataSource.getTopRatedTVShow())
              .thenThrow(TlsException());
          // act
          final theresult = await mockTvShowRepoImpl.getAllTopRatedTVShow();
          // assert
          verify(mockTvShowRemoteDataSource.getTopRatedTVShow());
          expect(theresult, equals(Left(FailureCommon('Certificated is not valid\n'))));
        });
  });

  group('Get TV Show Detail', () {
    final testtvShowId = 121;
    final testTVShowResponse = ModelTVShowDetailResponse(
      pathBackdrop: 'TVShowDetailBckDrpPath',
      genreTv: [ModelGenre(idGenre: 1, nameGenre: 'Action')],
      idTv: 1,
      language_original: 'en',
      name_original: 'original_name',
      overviewTv: 'overview',
      tvPopularity: 1,
      path_poster: 'posterPath',
      date_first_show: 'releaseDate',
      nameTv: 'name',
      tvVoteAverage: 1,
      tvVoteCount: 1,
    );

    test(
        'should return TV Show data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTVShowDetail(testtvShowId))
          .thenAnswer((_) async => testTVShowResponse);
      // act
      final theresult = await mockTvShowRepoImpl.getTVShowDetail(testtvShowId);
      // assert
      verify(mockTvShowRemoteDataSource.getTVShowDetail(testtvShowId));
      expect(theresult, equals(Right(testTVShowDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is not successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTVShowDetail(testtvShowId)).thenThrow(ExceptServer());
      // act
      final theresult = await mockTvShowRepoImpl.getTVShowDetail(testtvShowId);
      // assert
      verify(mockTvShowRemoteDataSource.getTVShowDetail(testtvShowId));
      expect(theresult, equals(Left(FailureServer(''))));
    });

    test(
        'should return connection failure when the device is disconnected to internet',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTVShowDetail(testtvShowId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final theresult = await mockTvShowRepoImpl.getTVShowDetail(testtvShowId);
      // assert
      verify(mockTvShowRemoteDataSource.getTVShowDetail(testtvShowId));
      expect(theresult,
          equals(Left(FailureConnection('Failed to connect to the network'))));
    });

    test(
        'should return Certification Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvShowRemoteDataSource.getTVShowDetail(testtvShowId))
              .thenThrow(TlsException());
          // act
          final theresult = await mockTvShowRepoImpl.getTVShowDetail(testtvShowId);
          // assert
          verify(mockTvShowRemoteDataSource.getTVShowDetail(testtvShowId));
          expect(theresult, equals(Left(FailureCommon('Certificated is not valid\n'))));
        });
  });

  group('Get TV Show Recommendations', () {
    final testTVShowList = <ModelTVShow>[];
    final testIdTVShow = 1;

    test('should return data tv show list recommendations when the call is successful', () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTVShowRecommendations(testIdTVShow))
          .thenAnswer((_) async => testTVShowList);
      // act
      final theresult = await mockTvShowRepoImpl.getAllTVShowRecommendations(testIdTVShow);
      // assert
      verify(mockTvShowRemoteDataSource.getTVShowRecommendations(testIdTVShow));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final tvshowresultList = theresult.getOrElse(() => []);
      expect(tvshowresultList, equals(testTVShowList));
    });

    test(
        'should return server failure when call to remote data source is not successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTVShowRecommendations(testIdTVShow))
          .thenThrow(ExceptServer());
      // act
      final theresult = await mockTvShowRepoImpl.getAllTVShowRecommendations(testIdTVShow);
      // assertbuild runner
      verify(mockTvShowRemoteDataSource.getTVShowRecommendations(testIdTVShow));
      expect(theresult, equals(Left(FailureServer(''))));
    });

    test(
        'should return connection failure when the device is disconnected to the internet',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTVShowRecommendations(testIdTVShow))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final theresult = await mockTvShowRepoImpl.getAllTVShowRecommendations(testIdTVShow);
      // assert
      verify(mockTvShowRemoteDataSource.getTVShowRecommendations(testIdTVShow));
      expect(theresult,
          equals(Left(FailureConnection('Failed to connect to the network'))));
    });

    test(
        'should return Certification Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvShowRemoteDataSource.getTVShowRecommendations(testIdTVShow))
              .thenThrow(TlsException());
          // act
          final theresult = await mockTvShowRepoImpl.getAllTVShowRecommendations(testIdTVShow);
          // assert
          verify(mockTvShowRemoteDataSource.getTVShowRecommendations(testIdTVShow));
          expect(theresult, equals(Left(FailureCommon('Certificated is not valid\n'))));
        });
  });

  group('Seach TV Show', () {
    final testTvShowQuery = 'spiderman';

    test('should return tv show list when call to data source is successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.searchTVShow(testTvShowQuery))
          .thenAnswer((_) async => testTVShowModelList);
      // act
      final theresult = await mockTvShowRepoImpl.searchTVSHow(testTvShowQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final tvshowresultList = theresult.getOrElse(() => []);
      expect(tvshowresultList, testTVShowList);
    });

    test('should return ServerFailure when call to data source is not successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.searchTVShow(testTvShowQuery)).thenThrow(ExceptServer());
      // act
      final theresult = await mockTvShowRepoImpl.searchTVSHow(testTvShowQuery);
      // assert
      expect(theresult, Left(FailureServer('')));
    });

    test(
        'should return ConnectionFailure when device is disconnected to the internet',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.searchTVShow(testTvShowQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final theresult = await mockTvShowRepoImpl.searchTVSHow(testTvShowQuery);
      // assert
      expect(
          theresult, Left(FailureConnection('Failed to connect to the network')));
    });

    test(
        'should return Certification Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvShowRemoteDataSource.searchTVShow(testTvShowQuery))
              .thenThrow(TlsException());
          // act
          final theresult = await mockTvShowRepoImpl.searchTVSHow(testTvShowQuery);
          // assert
          verify(mockTvShowRemoteDataSource.searchTVShow(testTvShowQuery));
          expect(theresult, equals(Left(FailureCommon('Certificated is not valid\n'))));
        });
  });


  group('get watchlist tv show status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final testIdTvShow = 1;
      when(mockTvShowLocalDataSource.getTVShowId(testIdTvShow)).thenAnswer((_) async => null);
      // act
      final theresult = await mockTvShowRepoImpl.isAddedToWatchlistTvShow(testIdTvShow);
      // assert
      expect(theresult, false);
    });
  });

  group('get watchlist tv show', () {
    test('should return list of TV Show', () async {
      // arrange
      when(mockTvShowLocalDataSource.getWatchlistTVShow())
          .thenAnswer((_) async => [testTVShowTable]);
      // act
      final theresult = await mockTvShowRepoImpl.getAllWatchlistTvShow();
      // assert
      final tvshowresultList = theresult.getOrElse(() => []);
      expect(tvshowresultList, [testWatchlistAllTVShow]);
    });
  });

  group('save watchlist Tv Show', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockTvShowLocalDataSource.addWatchlistTVShow(testTVShowTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final theresult = await mockTvShowRepoImpl.saveWatchlistTvShow(testTVShowDetail);
      // assert
      expect(theresult, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving is not successful', () async {
      // arrange
      when(mockTvShowLocalDataSource.addWatchlistTVShow(testTVShowTable))
          .thenThrow(ExcepDB('Failed to add watchlist'));
      // act
      final theresult = await mockTvShowRepoImpl.saveWatchlistTvShow(testTVShowDetail);
      // assert
      expect(theresult, Left(FailureDB('Failed to add watchlist')));
    });
  });

  group('delete watchlist tv show', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockTvShowLocalDataSource.deleteWatchlistTVShow(testTVShowTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final theresult = await mockTvShowRepoImpl.removeWatchlistTvShow(testTVShowDetail);
      // assert
      expect(theresult, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove is not successful', () async {
      // arrange
      when(mockTvShowLocalDataSource.deleteWatchlistTVShow(testTVShowTable))
          .thenThrow(ExcepDB('Failed to remove watchlist'));
      // act
      final theresult = await mockTvShowRepoImpl.removeWatchlistTvShow(testTVShowDetail);
      // assert
      expect(theresult, Left(FailureDB('Failed to remove watchlist')));
    });
  });
}
