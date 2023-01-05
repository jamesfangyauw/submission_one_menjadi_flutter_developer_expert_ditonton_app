import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_tv_show_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testTVShowModel = ModelTVShow(
    pathBackdrop: 'backdropPath',
    genreIdTv: [1, 2, 3],
    idTv: 1,
    name_origin: 'originalname',
    overview_tv: 'overview',
    tv_popularity: 1,
    path_poster: 'poster_path',
    date_first_show: 'first_air_date',
    nameTv: 'name',
    language_origin:  'original_language',
    average_vote: 1,
    count_vote: 1,
  );

  final testTVShow = TVEntities(
    pathBackdrop: 'backdropPath',
    genreIdsTv: [1, 2, 3],
    idTv: 1,
    name_original: 'originalname',
    tv_overview: 'overview',
    tv_popularity: 1,
    path_poster: 'poster_path',
    date_first_show: 'first_air_date',
    nameTv: 'name',
    language_original:  'original_language',
    tv_voteAverage: 1,
    tv_voteCount: 1,
  );

  test('should be a subclass of TV Show entity', () async {
    final theresult = testTVShowModel.toEntity();
    expect(theresult, testTVShow);
  });

  // test('should be a map of TVShow', () async {
  //   final testTVShowMap = testTVShowModel.toJson();
  //   final theresult = testTVShowModel.toEntity();
  //   expect(theresult, testTVShowMap);
  // });
  //
  // test('should be a TVShowDetailResponse instance', () async {
  //   final testTVShowMap = testTVShowModel.toJson();
  //   final result = ModelTVDetailResponse.fromJson(testTVShowMap);
  //   expect(result, testTVShowMap);
  // });
}
