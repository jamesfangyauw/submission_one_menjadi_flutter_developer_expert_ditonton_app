import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_tv_show_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_tv_show.mocks.dart';

void main() {
  late GetAllTVShowRecommendations getTvShowRecomendations;
  late TvShowRepoMock tvShowRepositoryMock;

  setUp(() {
    tvShowRepositoryMock = TvShowRepoMock();
    getTvShowRecomendations = GetAllTVShowRecommendations(tvShowRepositoryMock);
  });

  final testIdTvShow = 1;
  final testTVShow = <TVEntities>[];

  test('should get list of tv show recommendations from the repository',
      () async {
    // arrange
    when(tvShowRepositoryMock.getAllTVShowRecommendations(testIdTvShow))
        .thenAnswer((_) async => Right(testTVShow));
    // act
    final theresult = await getTvShowRecomendations.execute(testIdTvShow);
    // assert
    expect(theresult, Right(testTVShow));
  });
}
