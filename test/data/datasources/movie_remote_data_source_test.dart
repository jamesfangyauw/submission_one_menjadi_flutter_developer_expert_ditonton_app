import 'dart:convert';

import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/datasources/movie_remote_ds.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_movie_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/response_movie.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/excepDb.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  const KEY_API = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const URL_BASE = 'https://api.themoviedb.org/3';

  late MovieRemoteDataSourceImpl movieRemoteDSImpl;
  late MockHttpClient httpClientMock;

  setUp(() {
    httpClientMock = MockHttpClient();
    movieRemoteDSImpl = MovieRemoteDataSourceImpl(clientHTTP: httpClientMock);
  });

  group('get Now Playing Movies', () {
    final tMovieList = ResponseMovie.fromJson(
            json.decode(jsonReader('dummy_data/now_playing_movie.json')))
        .movieList;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(httpClientMock
              .get(Uri.parse('$URL_BASE/movie/now_playing?$KEY_API')))
          .thenAnswer((_) async =>
              http.Response(jsonReader('dummy_data/now_playing_movie.json'), 200));
      // act
      final theresult = await movieRemoteDSImpl.getNowPlayingAllMovies();
      // assert
      expect(theresult, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(httpClientMock
              .get(Uri.parse('$URL_BASE/movie/now_playing?$KEY_API')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final mssgcall = movieRemoteDSImpl.getNowPlayingAllMovies();
      // assert
      expect(() => mssgcall, throwsA(isA<ExceptServer>()));
    });
  });

  group('get Popular Movies', () {
    final tMovieList =
        ResponseMovie.fromJson(json.decode(jsonReader('dummy_data/popular_movie.json')))
            .movieList;

    test('should return list of movies when response is success (200)',
        () async {
      // arrange
      when(httpClientMock.get(Uri.parse('$URL_BASE/movie/popular?$KEY_API')))
          .thenAnswer((_) async =>
              http.Response(jsonReader('dummy_data/popular_movie.json'), 200));
      // act
      final theresult = await movieRemoteDSImpl.getPopularAllMovies();
      // assert
      expect(theresult, tMovieList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(httpClientMock.get(Uri.parse('$URL_BASE/movie/popular?$KEY_API')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final mssgcall = movieRemoteDSImpl.getPopularAllMovies();
      // assert
      expect(() => mssgcall, throwsA(isA<ExceptServer>()));
    });
  });

  group('get Top Rated Movies', () {
    final testMovieList = ResponseMovie.fromJson(
            json.decode(jsonReader('dummy_data/top_rated_movie.json')))
        .movieList;

    test('should return list of movies when response code is 200 ', () async {
      // arrange
      when(httpClientMock.get(Uri.parse('$URL_BASE/movie/top_rated?$KEY_API')))
          .thenAnswer((_) async =>
              http.Response(jsonReader('dummy_data/top_rated_movie.json'), 200));
      // act
      final theresult = await movieRemoteDSImpl.getTopRatedAllMovies();
      // assert
      expect(theresult, testMovieList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(httpClientMock.get(Uri.parse('$URL_BASE/movie/top_rated?$KEY_API')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final mssgcall = movieRemoteDSImpl.getTopRatedAllMovies();
      // assert
      expect(() => mssgcall, throwsA(isA<ExceptServer>()));
    });
  });

  group('get movie detail', () {
    final testId = 1;
    final testMovieDetail = ModelMovieDetailResponse.fromJson(
        json.decode(jsonReader('dummy_data/movie_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(httpClientMock.get(Uri.parse('$URL_BASE/movie/$testId?$KEY_API')))
          .thenAnswer((_) async =>
              http.Response(jsonReader('dummy_data/movie_detail.json'), 200));
      // act
      final theresult = await movieRemoteDSImpl.getMoviesDetail(testId);
      // assert
      expect(theresult, equals(testMovieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(httpClientMock.get(Uri.parse('$URL_BASE/movie/$testId?$KEY_API')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final mssgcall = movieRemoteDSImpl.getMoviesDetail(testId);
      // assert
      expect(() => mssgcall, throwsA(isA<ExceptServer>()));
    });
  });

  group('get movie recommendations', () {
    final tMovieList = ResponseMovie.fromJson(
            json.decode(jsonReader('dummy_data/movie_recommendations.json')))
        .movieList;
    final tId = 1;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(httpClientMock
              .get(Uri.parse('$URL_BASE/movie/$tId/recommendations?$KEY_API')))
          .thenAnswer((_) async => http.Response(
              jsonReader('dummy_data/movie_recommendations.json'), 200));
      // act
      final theresult = await movieRemoteDSImpl.getAllMovieRecommendations(tId);
      // assert
      expect(theresult, equals(tMovieList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(httpClientMock
              .get(Uri.parse('$URL_BASE/movie/$tId/recommendations?$KEY_API')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final mssgcall = movieRemoteDSImpl.getAllMovieRecommendations(tId);
      // assert
      expect(() => mssgcall, throwsA(isA<ExceptServer>()));
    });
  });

  group('search movies', () {
    final tSearchtheresult = ResponseMovie.fromJson(
            json.decode(jsonReader('dummy_data/search_spiderman_movie.json')))
        .movieList;
    final tQuery = 'Spiderman';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(httpClientMock
              .get(Uri.parse('$URL_BASE/search/movie?$KEY_API&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              jsonReader('dummy_data/search_spiderman_movie.json'), 200));
      // act
      final theresult = await movieRemoteDSImpl.searchTheMovies(tQuery);
      // assert
      expect(theresult, tSearchtheresult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(httpClientMock
              .get(Uri.parse('$URL_BASE/search/movie?$KEY_API&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final mssgcall = movieRemoteDSImpl.searchTheMovies(tQuery);
      // assert
      expect(() => mssgcall, throwsA(isA<ExceptServer>()));
    });
  });
}
