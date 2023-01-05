import 'dart:convert';

import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/response_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final testTVShowModel = ModelTVShow(
    pathBackdrop: '/jaejUwkiejLseprjaKSpqj12jeo12.jpg',
    genreIdTv: [31, 21, 12, 45],
    idTv: 321,
    name_origin: 'Wednesday',
    overview_tv: 'Having acquired the Power Stone–one of six Infinity Stones–from the planet Xandar, Thanos and his lieutenants: Ebony Maw, Cull Obsidian, Proxima Midnight, and Corvus Glaive, intercept the spaceship carrying the survivors of Asgar\'s destruction.[a] After subduing Thor, Thanos extracts the Space Stone from the Tesseract, overpowers the Hulk, and kills Loki. Thanos also kills Heimdall after he sends Hulk to Earth using the Bifröst. Thanos and his lieutenants leave, destroying the ship.Hulk crash-lands in the Sanctum Sanctorum in New York City, reverting to the form of Bruce Banner. He warns Stephen Strange and Wong about Thanos plan to destroy half of all life in the universe, and they recruit Tony Stark. Maw and Obsidian arrive to retrieve the Time Stone from Strange, drawing Peter Parker\'s attention. Maw, unable to take the Time Stone due to Strange\'s enchantment, captures him. Stark and Parker sneak aboard Maw\'s spaceship while Wong stays behind to guard the Sanctum.',
    tv_popularity: 3,
    path_poster: '/wjsJajeiHJHsleja12Jak343Jskeoa.jpg',
    date_first_show: '2021-09-25',
    nameTv: 'Wednesday',
    language_origin:  'en',
    average_vote: 8.0,
    count_vote: 955,
  );
  final testTVShowResponseModel =
      ResponseTVShow(tvShowList: <ModelTVShow>[testTVShowModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(jsonReader('dummy_data/now_playing_tv_show.json'));
      // act
      final theresult = ResponseTVShow.fromJson(jsonMap);
      // assert
      expect(theresult, testTVShowResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final theresult = testTVShowResponseModel.toJson();
      // assert
      final JSONMapExpected = {
        "results": [
          {
            "backdropPath": "/jaejUwkiejLseprjaKSpqj12jeo12.jpg",
            "genreIds": [31, 21, 12, 45],
            "id": 321,
            "original_name": "Wednesday",
            "overview": "Having acquired the Power Stone–one of six Infinity Stones–from the planet Xandar, Thanos and his lieutenants: Ebony Maw, Cull Obsidian, Proxima Midnight, and Corvus Glaive, intercept the spaceship carrying the survivors of Asgar\'s destruction.[a] After subduing Thor, Thanos extracts the Space Stone from the Tesseract, overpowers the Hulk, and kills Loki. Thanos also kills Heimdall after he sends Hulk to Earth using the Bifröst. Thanos and his lieutenants leave, destroying the ship.Hulk crash-lands in the Sanctum Sanctorum in New York City, reverting to the form of Bruce Banner. He warns Stephen Strange and Wong about Thanos plan to destroy half of all life in the universe, and they recruit Tony Stark. Maw and Obsidian arrive to retrieve the Time Stone from Strange, drawing Peter Parker\'s attention. Maw, unable to take the Time Stone due to Strange\'s enchantment, captures him. Stark and Parker sneak aboard Maw\'s spaceship while Wong stays behind to guard the Sanctum.",
            "popularity": 3,
            "poster_path": "/wjsJajeiHJHsleja12Jak343Jskeoa.jpg",
            "first_air_date": "2021-09-25",
            "name": "Wednesday",
            "original_language": "en",
            "vote_average": 8.0,
            "vote_count": 955
          }
        ],
      };
      expect(theresult, JSONMapExpected);
    });
  });
}
