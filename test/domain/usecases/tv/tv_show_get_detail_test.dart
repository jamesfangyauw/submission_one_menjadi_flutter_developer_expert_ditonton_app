import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_tv_show_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper_tv_show.mocks.dart';

void main() {
  late GetAllTVShowDetail getAllTvShowDetail;
  late TvShowRepoMock tVShowRepositoryMock;

  setUp(() {
    tVShowRepositoryMock = TvShowRepoMock();
    getAllTvShowDetail = GetAllTVShowDetail(tVShowRepositoryMock);
  });

  final testIdTvShow = 1;

  test('should get tv show detail from the repository', () async {
    // arrange
    when(tVShowRepositoryMock.getTVShowDetail(testIdTvShow))
        .thenAnswer((_) async => Right(testTVShowDetail));
    // act
    final theresult = await getAllTvShowDetail.execute(testIdTvShow);
    // assert
    expect(theresult, Right(testTVShowDetail));
  });
}
