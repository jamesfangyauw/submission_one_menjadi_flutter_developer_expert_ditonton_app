import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/search_all_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_show_search_notifier_test.mocks.dart';

@GenerateMocks([SearchAllTVShow])
void main() {
  late TVShowSearchNotifier tvShowSearchNotifier;
  late SearchTVShowMock searchTVShowMock;
  late int countlistenerCall;

  setUp(() {
    countlistenerCall = 0;
    searchTVShowMock = SearchTVShowMock();
    tvShowSearchNotifier = TVShowSearchNotifier(searchallTvShow: searchTVShowMock)
      ..addListener(() {
        countlistenerCall = countlistenerCall + 1;
      });
  });

  final testTVShowModel = TVEntities(
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
  final testTVShowList = <TVEntities>[testTVShowModel];
  final testTvQry = 'spiderman';

  group('search tvshow', () {
    test('should change state to DataLoading when usecase is called', () async {
      // arrange
      when(searchTVShowMock.execute(testTvQry))
          .thenAnswer((_) async => Right(testTVShowList));
      // act
      tvShowSearchNotifier.fetchTVShowSearch(testTvQry);
      // assert
      expect(tvShowSearchNotifier.tvShowState, EnumStateRequest.DataLoading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(searchTVShowMock.execute(testTvQry))
          .thenAnswer((_) async => Right(testTVShowList));
      // act
      await tvShowSearchNotifier.fetchTVShowSearch(testTvQry);
      // assert
      expect(tvShowSearchNotifier.tvShowState, EnumStateRequest.DataLoaded);
      expect(tvShowSearchNotifier.tvShowsearchResult, testTVShowList);
      expect(countlistenerCall, 2);
    });

    test('should return error when data is not successful', () async {
      // arrange
      when(searchTVShowMock.execute(testTvQry))
          .thenAnswer((_) async => Left(FailureServer('Server Failure')));
      // act
      await tvShowSearchNotifier.fetchTVShowSearch(testTvQry);
      // assert
      expect(tvShowSearchNotifier.tvShowState, EnumStateRequest.DataError);
      expect(tvShowSearchNotifier.mssg, 'Server Failure');
      expect(countlistenerCall, 2);
    });
  });
}
