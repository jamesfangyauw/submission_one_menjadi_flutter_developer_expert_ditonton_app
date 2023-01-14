import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_genre.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_movie_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_movie.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/repositories/movie_repo_impl.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/excepDb.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRepoImpl movieRepoImpl;
  late MockMovieRemoteDS theMovieRemoteDSMock;
  late MockMovieLocalDS theMovieLocalDSMock;

  setUp(() {
    theMovieRemoteDSMock = MockMovieRemoteDS();
    theMovieLocalDSMock = MockMovieLocalDS();
    movieRepoImpl = MovieRepoImpl(
      movieRemoteDS: theMovieRemoteDSMock,
      movieLocalDS: theMovieLocalDSMock,
    );
  });

  final testMovieModel = ModelMovie(
    adultMovie: false,
    backdropPathMovie: '/sjqperuandsfu23hfad433uiafasljc.jpg',
    genreIdsMovie: [9, 36, 21, 45],
    idMovie: 1023,
    originalTitleMovie: 'Star Wars: The Rise of Skywalker',
    overviewMovie:
        'Following a threat of revenge by the resurrected Emperor Palpatine, Kylo Ren obtains a Sith wayfinder that leads to the planet Exegol. There, he finds Palpatine, who reveals that he created Snoke to rule the First Order and lure Kylo to the dark side. Palpatine unveils the Final Order—a secret armada of superlaser-equipped Star Destroyers—and tells Kylo to find and kill Rey, who is continuing her Jedi training under Resistance leader Leia Organa. Poe Dameron and Finn deliver intelligence from a spy in the First Order that Palpatine is on Exegol; Rey reads in Luke Skywalker\'s notes that a Sith wayfinder can lead them there. Rey, Finn, Poe, Chewbacca, BB-8, and C-3PO depart in the Millennium Falcon to Pasaana, to find a hidden clue leading to a wayfinder.',
    popularityMovie: 100.987,
    posterPathMovie: '/sjaeIskjeJsksO93jaka83.jpg',
    releaseDateMovie: '2019-10-30',
    titleMovie: 'Star Wars: The Rise of Skywalker',
    videoMovie: false,
    voteAverageMovie: 8.0,
    voteCountMovie: 23456,
  );

  final testMovie = Movie(
    adultMovie: false,
    backdropPathMovie: '/sjqperuandsfu23hfad433uiafasljc.jpg',
    genreIdsMovie: [9, 36, 21, 45],
    idMovie: 1023,
    originalTitleMovie: 'Star Wars: The Rise of Skywalker',
    overviewMovie:
    'Following a threat of revenge by the resurrected Emperor Palpatine, Kylo Ren obtains a Sith wayfinder that leads to the planet Exegol. There, he finds Palpatine, who reveals that he created Snoke to rule the First Order and lure Kylo to the dark side. Palpatine unveils the Final Order—a secret armada of superlaser-equipped Star Destroyers—and tells Kylo to find and kill Rey, who is continuing her Jedi training under Resistance leader Leia Organa. Poe Dameron and Finn deliver intelligence from a spy in the First Order that Palpatine is on Exegol; Rey reads in Luke Skywalker\'s notes that a Sith wayfinder can lead them there. Rey, Finn, Poe, Chewbacca, BB-8, and C-3PO depart in the Millennium Falcon to Pasaana, to find a hidden clue leading to a wayfinder.',
    popularityMovie: 100.987,
    posterPathMovie: '/sjaeIskjeJsksO93jaka83.jpg',
    releaseDateMovie: '2019-10-30',
    titleMovie: 'Star Wars: The Rise of Skywalker',
    videoMovie: false,
    voteAverageMovie: 8.0,
    voteCountMovie: 23456,
  );

  final tMovieModelList = <ModelMovie>[testMovieModel];
  final tMovieList = <Movie>[testMovie];

  group('Now Playing Movies', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(theMovieRemoteDSMock.getNowPlayingAllMovies())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final theResult = await movieRepoImpl.getNowPlayingMovies();
      // assert
      verify(theMovieRemoteDSMock.getNowPlayingAllMovies());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final tvShowtheResultList = theResult.getOrElse(() => []);
      expect(tvShowtheResultList, tMovieList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(theMovieRemoteDSMock.getNowPlayingAllMovies())
          .thenThrow(ExceptServer());
      // act
      final theResult = await movieRepoImpl.getNowPlayingMovies();
      // assert
      verify(theMovieRemoteDSMock.getNowPlayingAllMovies());
      expect(theResult, equals(Left(FailureServer(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(theMovieRemoteDSMock.getNowPlayingAllMovies())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final theResult = await movieRepoImpl.getNowPlayingMovies();
      // assert
      verify(theMovieRemoteDSMock.getNowPlayingAllMovies());
      expect(theResult,
          equals(Left(FailureConnection('Failed to connect to the network'))));
    });

    test(
        'should return Certification Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(theMovieRemoteDSMock.getNowPlayingAllMovies())
              .thenThrow(TlsException());
          // act
          final result = await movieRepoImpl.getNowPlayingMovies();
          // assert
          verify(theMovieRemoteDSMock.getNowPlayingAllMovies());
          expect(result, equals(Left(FailureCommon('Certificated is not valid\n'))));
        });
  });

  group('Popular Movies', () {
    test('should return movie list when call to data source is success',
        () async {
      // arrange
      when(theMovieRemoteDSMock.getPopularAllMovies())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final theResult = await movieRepoImpl.getPopularMovies();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final tvShowtheResultList = theResult.getOrElse(() => []);
      expect(tvShowtheResultList, tMovieList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(theMovieRemoteDSMock.getPopularAllMovies())
          .thenThrow(ExceptServer());
      // act
      final theResult = await movieRepoImpl.getPopularMovies();
      // assert
      expect(theResult, Left(FailureServer('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(theMovieRemoteDSMock.getPopularAllMovies())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final theResult = await movieRepoImpl.getPopularMovies();
      // assert
      expect(
          theResult, Left(FailureConnection('Failed to connect to the network')));
    });

    test(
        'should return Certification Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(theMovieRemoteDSMock.getPopularAllMovies())
              .thenThrow(TlsException());
          // act
          final theresult = await movieRepoImpl.getPopularMovies();
          // assert
          verify(theMovieRemoteDSMock.getPopularAllMovies());
          expect(theresult, equals(Left(FailureCommon('Certificated is not valid\n'))));
        });
  });

  group('Top Rated Movies', () {
    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(theMovieRemoteDSMock.getTopRatedAllMovies())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final theResult = await movieRepoImpl.getTopRatedMovies();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final tvShowtheResultList = theResult.getOrElse(() => []);
      expect(tvShowtheResultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(theMovieRemoteDSMock.getTopRatedAllMovies())
          .thenThrow(ExceptServer());
      // act
      final theResult = await movieRepoImpl.getTopRatedMovies();
      // assert
      expect(theResult, Left(FailureServer('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(theMovieRemoteDSMock.getTopRatedAllMovies())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final theResult = await movieRepoImpl.getTopRatedMovies();
      // assert
      expect(
          theResult, Left(FailureConnection('Failed to connect to the network')));
    });

    test(
        'should return Certification Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(theMovieRemoteDSMock.getTopRatedAllMovies())
              .thenThrow(TlsException());
          // act
          final theresult = await movieRepoImpl.getTopRatedMovies();
          // assert
          verify(theMovieRemoteDSMock.getTopRatedAllMovies());
          expect(theresult, equals(Left(FailureCommon('Certificated is not valid\n'))));
        });
  });

  group('Get Movie Detail', () {
    final tId = 1;
    final tMovieResponse = ModelMovieDetailResponse(
      adultMovie: false,
      backdropPathMovie: 'MovieDetailBackdropPath',
      budgetMovie: 100,
      genresMovie: [ModelGenre(idGenre: 1, nameGenre: 'Action')],
      homepageMovie: "https://google.com",
      idMovie: 1,
      imdbIdMovie: 'imdb1',
      originalLanguageMovie: 'en',
      originalTitleMovie: 'originalTitle',
      overviewMovie: 'overview',
      popularityMovie: 1,
      posterPathMovie: 'posterPath',
      releaseDateMovie: 'releaseDate',
      revenueMovie: 12000,
      runtimeMovie: 120,
      statusMovie: 'Status',
      taglineMovie: 'Tagline',
      titleMovie: 'title',
      videoMovie: false,
      voteAverageMovie: 1,
      voteCountMovie: 1,
    );

    test(
        'should return Movie data when the call to remote data source is successful',
        () async {
      // arrange
      when(theMovieRemoteDSMock.getMoviesDetail(tId))
          .thenAnswer((_) async => tMovieResponse);
      // act
      final theResult = await movieRepoImpl.getMovieDetail(tId);
      // assert
      verify(theMovieRemoteDSMock.getMoviesDetail(tId));
      expect(theResult, equals(Right(testTheMovieDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(theMovieRemoteDSMock.getMoviesDetail(tId))
          .thenThrow(ExceptServer());
      // act
      final theResult = await movieRepoImpl.getMovieDetail(tId);
      // assert
      verify(theMovieRemoteDSMock.getMoviesDetail(tId));
      expect(theResult, equals(Left(FailureServer(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(theMovieRemoteDSMock.getMoviesDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final theResult = await movieRepoImpl.getMovieDetail(tId);
      // assert
      verify(theMovieRemoteDSMock.getMoviesDetail(tId));
      expect(theResult,
          equals(Left(FailureConnection('Failed to connect to the network'))));
    });
    test(
        'should return Certification Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(theMovieRemoteDSMock.getMoviesDetail(tId))
              .thenThrow(TlsException());
          // act
          final theresult = await movieRepoImpl.getMovieDetail(tId);
          // assert
          verify(theMovieRemoteDSMock.getMoviesDetail(tId));
          expect(theresult, equals(Left(FailureCommon('Certificated is not valid\n'))));
        });
  });

  group('Get Movie Recommendations', () {
    final tMovieList = <ModelMovie>[];
    final tId = 1;

    test('should return data (movie list) when the call is successful',
        () async {
      // arrange
      when(theMovieRemoteDSMock.getAllMovieRecommendations(tId))
          .thenAnswer((_) async => tMovieList);
      // act
      final theResult = await movieRepoImpl.getMovieRecommendations(tId);
      // assert
      verify(theMovieRemoteDSMock.getAllMovieRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final tvShowtheResultList = theResult.getOrElse(() => []);
      expect(tvShowtheResultList, equals(tMovieList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(theMovieRemoteDSMock.getAllMovieRecommendations(tId))
          .thenThrow(ExceptServer());
      // act
      final theResult = await movieRepoImpl.getMovieRecommendations(tId);
      // assertbuild runner
      verify(theMovieRemoteDSMock.getAllMovieRecommendations(tId));
      expect(theResult, equals(Left(FailureServer(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(theMovieRemoteDSMock.getAllMovieRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final theResult = await movieRepoImpl.getMovieRecommendations(tId);
      // assert
      verify(theMovieRemoteDSMock.getAllMovieRecommendations(tId));
      expect(theResult,
          equals(Left(FailureConnection('Failed to connect to the network'))));
    });
    test(
        'should return Certification Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(theMovieRemoteDSMock.getAllMovieRecommendations(tId))
              .thenThrow(TlsException());
          // act
          final theresult = await movieRepoImpl.getMovieRecommendations(tId);
          // assert
          verify(theMovieRemoteDSMock.getAllMovieRecommendations(tId));
          expect(theresult, equals(Left(FailureCommon('Certificated is not valid\n'))));
        });
  });

  group('Seach Movies', () {
    final tQuery = 'spiderman';

    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(theMovieRemoteDSMock.searchTheMovies(tQuery))
          .thenAnswer((_) async => tMovieModelList);
      // act
      final theResult = await movieRepoImpl.searchMovies(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final tvShowtheResultList = theResult.getOrElse(() => []);
      expect(tvShowtheResultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(theMovieRemoteDSMock.searchTheMovies(tQuery))
          .thenThrow(ExceptServer());
      // act
      final theResult = await movieRepoImpl.searchMovies(tQuery);
      // assert
      expect(theResult, Left(FailureServer('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(theMovieRemoteDSMock.searchTheMovies(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final theResult = await movieRepoImpl.searchMovies(tQuery);
      // assert
      expect(
          theResult, Left(FailureConnection('Failed to connect to the network')));
    });
    test(
        'should return Certification Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(theMovieRemoteDSMock.searchTheMovies(tQuery))
              .thenThrow(TlsException());
          // act
          final theresult = await movieRepoImpl.searchMovies(tQuery);
          // assert
          verify(theMovieRemoteDSMock.searchTheMovies(tQuery));
          expect(theresult, equals(Left(FailureCommon('Certificated is not valid\n'))));
        });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(theMovieLocalDSMock.addWatchlist(testTheMovieTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final theResult = await movieRepoImpl.saveWatchlist(testTheMovieDetail);
      // assert
      expect(theResult, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(theMovieLocalDSMock.addWatchlist(testTheMovieTable))
          .thenThrow(ExcepDB('Failed to add watchlist'));
      // act
      final theResult = await movieRepoImpl.saveWatchlist(testTheMovieDetail);
      // assert
      expect(theResult, Left(FailureDB('Failed to add watchlist')));
    });

  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(theMovieLocalDSMock.deleteWatchlist(testTheMovieTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final theResult = await movieRepoImpl.removeWatchlist(testTheMovieDetail);
      // assert
      expect(theResult, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(theMovieLocalDSMock.deleteWatchlist(testTheMovieTable))
          .thenThrow(ExcepDB('Failed to remove watchlist'));
      // act
      final theResult = await movieRepoImpl.removeWatchlist(testTheMovieDetail);
      // assert
      expect(theResult, Left(FailureDB('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(theMovieLocalDSMock.getMovieId(tId)).thenAnswer((_) async => null);
      // act
      final theResult = await movieRepoImpl.isAddedToWatchlist(tId);
      // assert
      expect(theResult, false);
    });
  });

  group('get watchlist movies', () {
    test('should return list of Movies', () async {
      // arrange
      when(theMovieLocalDSMock.getWatchlistAllMovie())
          .thenAnswer((_) async => [testTheMovieTable]);
      // act
      final theResult = await movieRepoImpl.getWatchlistMovies();
      // assert
      final tvShowtheResultList = theResult.getOrElse(() => []);
      expect(tvShowtheResultList, [testWatchlistAllMovie]);
    });
  });
}
