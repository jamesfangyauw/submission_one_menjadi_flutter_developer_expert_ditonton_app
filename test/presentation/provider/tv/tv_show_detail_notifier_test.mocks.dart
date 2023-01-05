// Mocks generated by Mockito 5.0.8 from annotations
// in submission_one_menjadi_flutter_developer_expert_ditonton_app/test/presentation/provider/tv_show_detail_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart' as _i6;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart' as _i9;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_detail.dart' as _i7;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/repositories/tv_show_repo.dart' as _i2;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_tv_show_detail.dart' as _i4;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_tv_show_recommendations.dart' as _i8;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_watchlist_tv_show_status.dart' as _i10;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/remove_all_watchlist_tv_show.dart' as _i12;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/save_all_watchlist_tv_show.dart' as _i11;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeTVShowRepository extends _i1.Fake implements _i2.TVShowRepo {}

class _FakeEither<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetTVDetail].
///
/// See the documentation for Mockito's code generation for more information.
class GetTVShowDetailMock extends _i1.Mock implements _i4.GetAllTVShowDetail {
  GetTVShowDetailMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVShowRepo get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVShowRepository()) as _i2.TVShowRepo);
  @override
  _i5.Future<_i3.Either<_i6.FailureEquitable, _i7.TVShowDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i3.Either<_i6.FailureEquitable, _i7.TVShowDetail>>.value(
              _FakeEither<_i6.FailureEquitable, _i7.TVShowDetail>())) as _i5
          .Future<_i3.Either<_i6.FailureEquitable, _i7.TVShowDetail>>);
}

/// A class which mocks [GetTVRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class GetTVShowRecommendationsMock extends _i1.Mock
    implements _i8.GetTVShowRecommendations {
  GetTVShowRecommendationsMock() {
    _i1.throwOnMissingStub(this);
  }
  @override
  _i2.TVShowRepo get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVShowRepository()) as _i2.TVShowRepo);
  @override
  _i5.Future<_i3.Either<_i6.FailureEquitable, List<_i9.TVEntities>>> execute(dynamic id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i3.Either<_i6.FailureEquitable, List<_i9.TVEntities>>>.value(
              _FakeEither<_i6.FailureEquitable, List<_i9.TVEntities>>())) as _i5
          .Future<_i3.Either<_i6.FailureEquitable, List<_i9.TVEntities>>>);
}

/// A class which mocks [GetWatchListStatus].
///
/// See the documentation for Mockito's code generation for more information.
class GetWatchListTvShowStatusMock extends _i1.Mock
    implements _i10.GetAllWatchListStatusTVShow {
  GetWatchListTvShowStatusMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVShowRepo get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVShowRepository()) as _i2.TVShowRepo);
  @override
  _i5.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
}

/// A class which mocks [SaveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class SaveWatchlistTvShowMock extends _i1.Mock implements _i11.SaveAllWatchlistTVShow {
  SaveWatchlistTvShowMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVShowRepo get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVShowRepository()) as _i2.TVShowRepo);
  @override
  _i5.Future<_i3.Either<_i6.FailureEquitable, String>> execute(_i7.TVShowDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue: Future<_i3.Either<_i6.FailureEquitable, String>>.value(
                  _FakeEither<_i6.FailureEquitable, String>()))
          as _i5.Future<_i3.Either<_i6.FailureEquitable, String>>);
}

/// A class which mocks [RemoveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class RemoveWatchlistTvShowMock extends _i1.Mock implements _i12.RemoveAllWatchlistTVShow {
  RemoveWatchlistTvShowMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVShowRepo get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVShowRepository()) as _i2.TVShowRepo);
  @override
  _i5.Future<_i3.Either<_i6.FailureEquitable, String>> execute(_i7.TVShowDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue: Future<_i3.Either<_i6.FailureEquitable, String>>.value(
                  _FakeEither<_i6.FailureEquitable, String>()))
          as _i5.Future<_i3.Either<_i6.FailureEquitable, String>>);
}
