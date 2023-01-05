import 'dart:convert';

import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_movie.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/response_movie.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tMovieModel = ModelMovie(
    adultMovie: false,
    backdropPathMovie: "/path.jpg",
    genreIdsMovie: [1, 2, 3, 4],
    idMovie: 1,
    originalTitleMovie: "Original Title",
    overviewMovie: "Overview",
    popularityMovie: 1.0,
    posterPathMovie: "/path.jpg",
    releaseDateMovie: "2020-05-05",
    titleMovie: "Title",
    videoMovie: false,
    voteAverageMovie: 1.0,
    voteCountMovie: 1,
  );
  final tMovieResponseModel =
      ResponseMovie(movieList: <ModelMovie>[tMovieModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(jsonReader('dummy_data/now_playing_movie.json'));
      // act
      final theresult = ResponseMovie.fromJson(jsonMap);
      // assert
      expect(theresult, tMovieResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final theresult = tMovieResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/path.jpg",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "original_title": "Original Title",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "release_date": "2020-05-05",
            "title": "Title",
            "video": false,
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };
      expect(theresult, expectedJsonMap);
    });
  });
}
