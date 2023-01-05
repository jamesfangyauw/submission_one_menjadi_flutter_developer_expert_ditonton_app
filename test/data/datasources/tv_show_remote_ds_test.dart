import 'dart:convert';

import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/datasources/tv_remote_ds.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_tv_show_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/response_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/excepDb.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../json_reader.dart';
import '../../helpers/test_helper_tv_show.mocks.dart';

void main() {
  const KEY_API = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const URL_BASE = 'https://api.themoviedb.org/3';

  late TVShowRemoteDSImpl tvShowRemoteDSImpl;
  late HttpClientTvShowMock tvShowHttpClientMock;

  setUp(() {
    tvShowHttpClientMock = HttpClientTvShowMock();
    tvShowRemoteDSImpl = TVShowRemoteDSImpl(clientHTTP: tvShowHttpClientMock);
  });

  group('get Now Playing TV Show', () {
    final testTVShowList = ResponseTVShow.fromJson(
            json.decode(jsonReader('dummy_data/popular_tv_show.json')))
        .tvShowList;

    test('should return list of TV Show Model when the response code is 200',
        () async {
      // arrange
      when(tvShowHttpClientMock
              .get(Uri.parse('$URL_BASE/tv/on_the_air?$KEY_API')))
          .thenAnswer((_) async =>
              http.Response(jsonReader('dummy_data/popular_tv_show.json'), 200));
      // act
      final theresult = await tvShowRemoteDSImpl.getNowPlayingTVShow();
      // assert
      expect(theresult, equals(testTVShowList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(tvShowHttpClientMock
              .get(Uri.parse('$URL_BASE/tv/on_the_air?$KEY_API')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final mssgcall = tvShowRemoteDSImpl.getNowPlayingTVShow();
      // assert
      expect(() => mssgcall, throwsA(isA<ExceptServer>()));
    });
  });

  group('get All Popular TV Show', () {
    final testTVShowList =
        ResponseTVShow.fromJson(json.decode(jsonReader('dummy_data/popular_tv_show.json')))
            .tvShowList;

    test('should return all list of tv show when response is success (200)',
        () async {
      // arrange
      when(tvShowHttpClientMock.get(Uri.parse('$URL_BASE/tv/popular?$KEY_API')))
          .thenAnswer((_) async =>
              http.Response(jsonReader('dummy_data/popular_tv_show.json'), 200));
      // act
      final theresult = await tvShowRemoteDSImpl.getPopularTVShow();
      // assert
      expect(theresult, testTVShowList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(tvShowHttpClientMock.get(Uri.parse('$URL_BASE/tv/popular?$KEY_API')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final mssgcall = tvShowRemoteDSImpl.getPopularTVShow();
      // assert
      expect(() => mssgcall, throwsA(isA<ExceptServer>()));
    });
  });

  group('get All Top Rated TV Show', () {
    final testTVShowList = ResponseTVShow.fromJson(
            json.decode(jsonReader('dummy_data/popular_tv_show.json')))
        .tvShowList;

    test('should return list of tv show when response code is 200 ', () async {
      // arrange
      when(tvShowHttpClientMock.get(Uri.parse('$URL_BASE/tv/top_rated?$KEY_API')))
          .thenAnswer((_) async =>
              http.Response(jsonReader('dummy_data/popular_tv_show.json'), 200));
      // act
      final theresult = await tvShowRemoteDSImpl.getTopRatedTVShow();
      // assert
      expect(theresult, testTVShowList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(tvShowHttpClientMock.get(Uri.parse('$URL_BASE/tv/top_rated?$KEY_API')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final mssgcall = tvShowRemoteDSImpl.getTopRatedTVShow();
      // assert
      expect(() => mssgcall, throwsA(isA<ExceptServer>()));
    });
  });

  group('get tv show detail', () {
    final tvShowId = 1;
    final testTVShowDetail = ModelTVShowDetailResponse.fromJson(
        json.decode(jsonReader('dummy_data/tv_show_detail.json')));

    test('should return tv show detail when the response code is 200', () async {
      // arrange
      when(tvShowHttpClientMock.get(Uri.parse('$URL_BASE/tv/$tvShowId?$KEY_API')))
          .thenAnswer((_) async =>
              http.Response(jsonReader('dummy_data/tv_show_detail.json'), 200));
      // act
      final theresult = await tvShowRemoteDSImpl.getTVShowDetail(tvShowId);
      // assert
      expect(theresult, equals(testTVShowDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(tvShowHttpClientMock.get(Uri.parse('$URL_BASE/tv/$tvShowId?$KEY_API')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final mssgcall = tvShowRemoteDSImpl.getTVShowDetail(tvShowId);
      // assert
      expect(() => mssgcall, throwsA(isA<ExceptServer>()));
    });
  });

  group('get all tv show recommendations', () {
    final testTVShowList = ResponseTVShow.fromJson(
            json.decode(jsonReader('dummy_data/popular_tv_show.json')))
        .tvShowList;
    final tvShowId = 1;

    test('should return list of TV Show Model when the response code is 200',
        () async {
      // arrange
      when(tvShowHttpClientMock
              .get(Uri.parse('$URL_BASE/tv/$tvShowId/recommendations?$KEY_API')))
          .thenAnswer((_) async => http.Response(
              jsonReader('dummy_data/popular_tv_show.json'), 200));
      // act
      final theresult = await tvShowRemoteDSImpl.getTVShowRecommendations(tvShowId);
      // assert
      expect(theresult, equals(testTVShowList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(tvShowHttpClientMock
              .get(Uri.parse('$URL_BASE/tv/$tvShowId/recommendations?$KEY_API')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final mssgcall = tvShowRemoteDSImpl.getTVShowRecommendations(tvShowId);
      // assert
      expect(() => mssgcall, throwsA(isA<ExceptServer>()));
    });
  });

  group('search tv show', () {
    final tvShowSearchResult = ResponseTVShow.fromJson(
            json.decode(jsonReader('dummy_data/popular_tv_show.json')))
        .tvShowList;
    final tvShowQuery = 'Spiderman';

    test('should return list of tv show when response code is 200', () async {
      // arrange
      when(tvShowHttpClientMock
              .get(Uri.parse('$URL_BASE/search/tv?$KEY_API&query=$tvShowQuery')))
          .thenAnswer((_) async => http.Response(
              jsonReader('dummy_data/popular_tv_show.json'), 200));
      // act
      final theresult = await tvShowRemoteDSImpl.searchTVShow(tvShowQuery);
      // assert
      expect(theresult, tvShowSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(tvShowHttpClientMock
              .get(Uri.parse('$URL_BASE/search/tv?$KEY_API&query=$tvShowQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final mssgcall = tvShowRemoteDSImpl.searchTVShow(tvShowQuery);
      // assert
      expect(() => mssgcall, throwsA(isA<ExceptServer>()));
    });
  });
}
