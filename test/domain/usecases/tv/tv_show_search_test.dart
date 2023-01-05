import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/search_all_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_tv_show.mocks.dart';

void main() {
  late SearchAllTVShow searchAllTvShow;
  late TvShowRepoMock tVShowRepositoryMock;

  setUp(() {
    tVShowRepositoryMock = TvShowRepoMock();
    searchAllTvShow = SearchAllTVShow(tVShowRepositoryMock);
  });

  final testTVShow = <TVEntities>[];
  final testTvShowQuery = 'Wednesday';

  test('should get list of tv show from the repository', () async {
    // arrange
    when(tVShowRepositoryMock.searchTVSHow(testTvShowQuery))
        .thenAnswer((_) async => Right(testTVShow));
    // act
    final theresult = await searchAllTvShow.execute(testTvShowQuery);
    // assert
    expect(theresult, Right(testTVShow));
  });
}
