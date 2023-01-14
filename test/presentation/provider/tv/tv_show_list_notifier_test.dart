import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_now_playing_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_popular_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_top_rated_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_list_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_show_list_notifier_test.mocks.dart';


@GenerateMocks([GetAllNowPlayingTVShow, GetAllPopularTVShow, GetTopRatedTVShow])
void main() {
  late TVShowListNotifier tvShowListNotifier;
  late MockGetAllNowPlayingTVShow getNowPlayingTVShowMock;
  late MockGetAllPopularTVShow getPopularTVShowMock;
  late MockGetTopRatedTV getTopRatedTVShowMock;
  late int countListenerCall;

  setUp(() {
    countListenerCall = 0;
    getNowPlayingTVShowMock = MockGetAllNowPlayingTVShow();
    getPopularTVShowMock = MockGetAllPopularTVShow();
    getTopRatedTVShowMock = MockGetTopRatedTV();
    tvShowListNotifier = TVShowListNotifier(
      getAllNowPlayingTVShow: getNowPlayingTVShowMock,
      getAllPopularTVShow: getPopularTVShowMock,
      getAllTopRatedTVShow: getTopRatedTVShowMock,
    )..addListener(() {
        countListenerCall = countListenerCall+ 1;
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

  group('now playing tv show', () {
    test('initialState should be Empty', () {
      expect(tvShowListNotifier.tvShowNowPlayingState, equals(EnumStateRequest.DataEmpty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(getNowPlayingTVShowMock.execute())
          .thenAnswer((_) async => Right(testTVShowList));
      // act
      tvShowListNotifier.fetchNowPlayingTVShow();
      // assert
      verify(getNowPlayingTVShowMock.execute());
    });

    test('should change state to DataLoading when usecase is called', () {
      // arrange
      when(getNowPlayingTVShowMock.execute())
          .thenAnswer((_) async => Right(testTVShowList));
      // act
      tvShowListNotifier.fetchNowPlayingTVShow();
      // assert
      expect(tvShowListNotifier.tvShowNowPlayingState, EnumStateRequest.DataLoading);
    });

    test('should change tv show when data is gotten successfully', () async {
      // arrange
      when(getNowPlayingTVShowMock.execute())
          .thenAnswer((_) async => Right(testTVShowList));
      // act
      await tvShowListNotifier.fetchNowPlayingTVShow();
      // assert
      expect(tvShowListNotifier.tvShowNowPlayingState, EnumStateRequest.DataLoaded);
      expect(tvShowListNotifier.tvShowNowPlaying, testTVShowList);
      expect(countListenerCall, 2);
    });

    test('should return error when data is not successful', () async {
      // arrange
      when(getNowPlayingTVShowMock.execute())
          .thenAnswer((_) async => Left(FailureServer('Server Failure')));
      // act
      await tvShowListNotifier.fetchNowPlayingTVShow();
      // assert
      expect(tvShowListNotifier.tvShowNowPlayingState, EnumStateRequest.DataError);
      expect(tvShowListNotifier.mssg, 'Server Failure');
      expect(countListenerCall, 2);
    });
  });

  group('popular tv show', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(getPopularTVShowMock.execute())
          .thenAnswer((_) async => Right(testTVShowList));
      // act
      tvShowListNotifier.fetchPopularTVShow();
      // assert
      expect(tvShowListNotifier.tvShowpopularTVState, EnumStateRequest.DataLoading);
      // verify(tvShowListNotifier.setState(RequestState.Loading));
    });

    test('should change tv show data when data is gotten successfully',
        () async {
      // arrange
      when(getPopularTVShowMock.execute())
          .thenAnswer((_) async => Right(testTVShowList));
      // act
      await tvShowListNotifier.fetchPopularTVShow();
      // assert
      expect(tvShowListNotifier.tvShowpopularTVState, EnumStateRequest.DataLoaded);
      expect(tvShowListNotifier.tvShowpopular, testTVShowList);
      expect(countListenerCall, 2);
    });

    test('should return error when data is not successful', () async {
      // arrange
      when(getPopularTVShowMock.execute())
          .thenAnswer((_) async => Left(FailureServer('Server Failure')));
      // act
      await tvShowListNotifier.fetchPopularTVShow();
      // assert
      expect(tvShowListNotifier.tvShowpopularTVState, EnumStateRequest.DataError);
      expect(tvShowListNotifier.mssg, 'Server Failure');
      expect(countListenerCall, 2);
    });
  });

  group('top rated tv show', () {
    test('should change state to DataLoading when usecase is called', () async {
      // arrange
      when(getTopRatedTVShowMock.execute())
          .thenAnswer((_) async => Right(testTVShowList));
      // act
      tvShowListNotifier.fetchTopRatedTVShow();
      // assert
      expect(tvShowListNotifier.tvShowtopRatedTVState, EnumStateRequest.DataLoading);
    });

    test('should change tv show data when data is gotten successfully',
        () async {
      // arrange
      when(getTopRatedTVShowMock.execute())
          .thenAnswer((_) async => Right(testTVShowList));
      // act
      await tvShowListNotifier.fetchTopRatedTVShow();
      // assert
      expect(tvShowListNotifier.tvShowtopRatedTVState, EnumStateRequest.DataLoaded);
      expect(tvShowListNotifier.tvShowtopRatedTV, testTVShowList);
      expect(countListenerCall, 2);
    });

    test('should return error when data is not successful', () async {
      // arrange
      when(getTopRatedTVShowMock.execute())
          .thenAnswer((_) async => Left(FailureServer('Server Failure')));
      // act
      await tvShowListNotifier.fetchTopRatedTVShow();
      // assert
      expect(tvShowListNotifier.tvShowtopRatedTVState, EnumStateRequest.DataError);
      expect(tvShowListNotifier.mssg, 'Server Failure');
      expect(countListenerCall, 2);
    });
  });
}
