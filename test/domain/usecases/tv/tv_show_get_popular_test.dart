import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_popular_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_tv_show.mocks.dart';

void main() {
  late GetAllPopularTVShow getAllPopularTvShow;
  late TvShowRepoMock TVShowRepositoryMock;

  setUp(() {
    TVShowRepositoryMock = TvShowRepoMock();
    getAllPopularTvShow = GetAllPopularTVShow(TVShowRepositoryMock);
  });

  final testTVShow = <TVEntities>[];

  group('GetAllPopularTVShow Test', () {
    group('execute', () {
      test(
          'should get list of TV Show from the repository when execute function is called',
          () async {
        // arrange
        when(TVShowRepositoryMock.getPopularAllTVShow())
            .thenAnswer((_) async => Right(testTVShow));
        // act
        final theresult = await getAllPopularTvShow.execute();
        // assert
        expect(theresult, Right(testTVShow));
      });
    });
  });
}
