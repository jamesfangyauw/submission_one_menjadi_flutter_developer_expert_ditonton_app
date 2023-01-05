import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_top_rated_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_tv_show.mocks.dart';

void main() {
  late GetTopRatedTV getTopRatedTvShow;
  late TvShowRepoMock tVShowRepositoryMock;

  setUp(() {
    tVShowRepositoryMock = TvShowRepoMock();
    getTopRatedTvShow = GetTopRatedTV(tVShowRepositoryMock);
  });

  final testTVShow = <TVEntities>[];

  test('should get list of TV Show from repository', () async {
    // arrange
    when(tVShowRepositoryMock.getAllTopRatedTVShow())
        .thenAnswer((_) async => Right(testTVShow));
    // act
    final theresult = await getTopRatedTvShow.execute();
    // assert
    expect(theresult, Right(testTVShow));
  });
}
