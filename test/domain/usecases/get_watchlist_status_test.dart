import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetAllWatchListTvShowStatus theusecase;
  late AllMovieRepoMock allMoviesRepoMock;

  setUp(() {
    allMoviesRepoMock = AllMovieRepoMock();
    theusecase = GetAllWatchListTvShowStatus(allMoviesRepoMock);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(allMoviesRepoMock.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final theresult = await theusecase.execute(1);
    // assert
    expect(theresult, true);
  });
}
