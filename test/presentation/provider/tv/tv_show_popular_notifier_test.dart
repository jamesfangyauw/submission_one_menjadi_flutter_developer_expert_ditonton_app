import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_popular_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_popular_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tv_show_popular_notifier_test.mocks.dart';

@GenerateMocks([GetAllPopularTVShow])
void main() {
  late MockGetAllPopularTVShow getPopularTVShowMock;
  late TvShowPopularNotifier notifier;
  late int countListenerCall;

  setUp(() {
    countListenerCall = 0;
    getPopularTVShowMock= MockGetAllPopularTVShow();
    notifier = TvShowPopularNotifier(getPopularTVShowMock)
      ..addListener(() {
        countListenerCall++;
      });
  });

  final testTVShow = TVEntities(
    pathBackdrop: 'backdropPath',
    genreIdsTv: [1, 2, 3],
    idTv: 1,
    name_original: 'originalTitle',
    tv_overview: 'overview',
    tv_popularity: 1,
    path_poster: 'posterPath',
    date_first_show:  'releaseDate',
    nameTv : 'title',
    language_original: 'EN',
    tv_voteAverage: 1,
    tv_voteCount: 1,
  );

  final testTVShowList = <TVEntities>[testTVShow];

  test('should change state to DataLoading when usecase is called', () async {
    // arrange
    when(getPopularTVShowMock.execute())
        .thenAnswer((_) async => Right(testTVShowList));
    // act
    notifier.fetchPopularTVShow();
    // assert
    expect(notifier.stateRequest, EnumStateRequest.DataLoading);
    expect(countListenerCall, 1);
  });

  test('should change tv data when data is gotten successfully', () async {
    // arrange
    when(getPopularTVShowMock.execute())
        .thenAnswer((_) async => Right(testTVShowList));
    // act
    await notifier.fetchPopularTVShow();
    // assert
    expect(notifier.stateRequest, EnumStateRequest.DataLoaded);
    expect(notifier.tvShow, testTVShowList);
    expect(countListenerCall, 2);
  });

  test('should return error when data is not successful', () async {
    // arrange
    when(getPopularTVShowMock.execute())
        .thenAnswer((_) async => Left(FailureServer('Server Failure')));
    // act
    await notifier.fetchPopularTVShow();
    // assert
    expect(notifier.stateRequest, EnumStateRequest.DataError);
    expect(notifier.mssg, 'Server Failure');
    expect(countListenerCall, 2);
  });
}
