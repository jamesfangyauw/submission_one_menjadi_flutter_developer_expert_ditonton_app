import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetAllMovieDetail getAllMovieDetail;
  late AllMovieRepoMock movieRepositoryMock;

  setUp(() {
    movieRepositoryMock = AllMovieRepoMock();
    getAllMovieDetail = GetAllMovieDetail(movieRepositoryMock);
  });

  final testId = 1;

  test('should get movie detail from the repository', () async {
    // arrange
    when(movieRepositoryMock.getMovieDetail(testId))
        .thenAnswer((_) async => Right(testTheMovieDetail));
    // act
    final theresult = await getAllMovieDetail.execute(testId);
    // assert
    expect(theresult, Right(testTheMovieDetail));
  });
}
