// Mocks generated by Mockito 5.3.2 from annotations
// in submission_one_menjadi_flutter_developer_expert_ditonton_app/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:convert' as _i17;
import 'dart:typed_data' as _i18;

import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i15;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart'
    as _i7;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/datasources/db/db_helper.dart'
    as _i14;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/datasources/movie_local_ds.dart'
    as _i12;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/datasources/movie_remote_ds.dart'
    as _i10;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_movie.dart'
    as _i11;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_movie_detail.dart'
    as _i3;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/table_movie.dart'
    as _i13;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/table_tv.dart'
    as _i16;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_detail.dart'
    as _i9;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart'
    as _i8;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/repositories/movie_repo.dart'
    as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeModelMovieDetailResponse_1 extends _i1.SmartFake
    implements _i3.ModelMovieDetailResponse {
  _FakeModelMovieDetailResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_2 extends _i1.SmartFake implements _i4.Response {
  _FakeResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_3 extends _i1.SmartFake
    implements _i4.StreamedResponse {
  _FakeStreamedResponse_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class AllMovieRepoMock extends _i1.Mock implements _i5.MovieRepository {
  AllMovieRepoMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.FailureEquitable, List<_i8.Movie>>>
      getNowPlayingMovies() => (super.noSuchMethod(
            Invocation.method(
              #getNowPlayingMovies,
              [],
            ),
            returnValue: _i6.Future<
                    _i2.Either<_i7.FailureEquitable, List<_i8.Movie>>>.value(
                _FakeEither_0<_i7.FailureEquitable, List<_i8.Movie>>(
              this,
              Invocation.method(
                #getNowPlayingMovies,
                [],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.FailureEquitable, List<_i8.Movie>>>);
  @override
  _i6.Future<
      _i2
          .Either<_i7.FailureEquitable, List<_i8.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.FailureEquitable, List<_i8.Movie>>>.value(
                _FakeEither_0<_i7.FailureEquitable, List<_i8.Movie>>(
          this,
          Invocation.method(
            #getPopularMovies,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.FailureEquitable, List<_i8.Movie>>>);
  @override
  _i6.Future<
      _i2
          .Either<_i7.FailureEquitable, List<_i8.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.FailureEquitable, List<_i8.Movie>>>.value(
                _FakeEither_0<_i7.FailureEquitable, List<_i8.Movie>>(
          this,
          Invocation.method(
            #getTopRatedMovies,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.FailureEquitable, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.FailureEquitable, _i9.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieDetail,
          [id],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.FailureEquitable, _i9.MovieDetail>>.value(
                _FakeEither_0<_i7.FailureEquitable, _i9.MovieDetail>(
          this,
          Invocation.method(
            #getMovieDetail,
            [id],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.FailureEquitable, _i9.MovieDetail>>);
  @override
  _i6.Future<_i2.Either<_i7.FailureEquitable, List<_i8.Movie>>>
      getMovieRecommendations(int? id) => (super.noSuchMethod(
            Invocation.method(
              #getMovieRecommendations,
              [id],
            ),
            returnValue: _i6.Future<
                    _i2.Either<_i7.FailureEquitable, List<_i8.Movie>>>.value(
                _FakeEither_0<_i7.FailureEquitable, List<_i8.Movie>>(
              this,
              Invocation.method(
                #getMovieRecommendations,
                [id],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.FailureEquitable, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.FailureEquitable, List<_i8.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.FailureEquitable, List<_i8.Movie>>>.value(
                _FakeEither_0<_i7.FailureEquitable, List<_i8.Movie>>(
          this,
          Invocation.method(
            #searchMovies,
            [query],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.FailureEquitable, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.FailureEquitable, String>> saveWatchlist(
          _i9.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlist,
          [movie],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.FailureEquitable, String>>.value(
            _FakeEither_0<_i7.FailureEquitable, String>(
          this,
          Invocation.method(
            #saveWatchlist,
            [movie],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.FailureEquitable, String>>);
  @override
  _i6.Future<_i2.Either<_i7.FailureEquitable, String>> removeWatchlist(
          _i9.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [movie],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.FailureEquitable, String>>.value(
            _FakeEither_0<_i7.FailureEquitable, String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [movie],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.FailureEquitable, String>>);
  @override
  _i6.Future<bool> isAddedToWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToWatchlist,
          [id],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);
  @override
  _i6.Future<_i2.Either<_i7.FailureEquitable, List<_i8.Movie>>>
      getWatchlistMovies() => (super.noSuchMethod(
            Invocation.method(
              #getWatchlistMovies,
              [],
            ),
            returnValue: _i6.Future<
                    _i2.Either<_i7.FailureEquitable, List<_i8.Movie>>>.value(
                _FakeEither_0<_i7.FailureEquitable, List<_i8.Movie>>(
              this,
              Invocation.method(
                #getWatchlistMovies,
                [],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.FailureEquitable, List<_i8.Movie>>>);
}

/// A class which mocks [MovieRemoteDS].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDS extends _i1.Mock implements _i10.MovieRemoteDS {
  MockMovieRemoteDS() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i11.ModelMovie>> getNowPlayingAllMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingAllMovies,
          [],
        ),
        returnValue:
            _i6.Future<List<_i11.ModelMovie>>.value(<_i11.ModelMovie>[]),
      ) as _i6.Future<List<_i11.ModelMovie>>);
  @override
  _i6.Future<List<_i11.ModelMovie>> getPopularAllMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularAllMovies,
          [],
        ),
        returnValue:
            _i6.Future<List<_i11.ModelMovie>>.value(<_i11.ModelMovie>[]),
      ) as _i6.Future<List<_i11.ModelMovie>>);
  @override
  _i6.Future<List<_i11.ModelMovie>> getTopRatedAllMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedAllMovies,
          [],
        ),
        returnValue:
            _i6.Future<List<_i11.ModelMovie>>.value(<_i11.ModelMovie>[]),
      ) as _i6.Future<List<_i11.ModelMovie>>);
  @override
  _i6.Future<_i3.ModelMovieDetailResponse> getMoviesDetail(int? idMovies) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMoviesDetail,
          [idMovies],
        ),
        returnValue: _i6.Future<_i3.ModelMovieDetailResponse>.value(
            _FakeModelMovieDetailResponse_1(
          this,
          Invocation.method(
            #getMoviesDetail,
            [idMovies],
          ),
        )),
      ) as _i6.Future<_i3.ModelMovieDetailResponse>);
  @override
  _i6.Future<List<_i11.ModelMovie>> getAllMovieRecommendations(int? idMovies) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllMovieRecommendations,
          [idMovies],
        ),
        returnValue:
            _i6.Future<List<_i11.ModelMovie>>.value(<_i11.ModelMovie>[]),
      ) as _i6.Future<List<_i11.ModelMovie>>);
  @override
  _i6.Future<List<_i11.ModelMovie>> searchTheMovies(String? queryMovies) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchTheMovies,
          [queryMovies],
        ),
        returnValue:
            _i6.Future<List<_i11.ModelMovie>>.value(<_i11.ModelMovie>[]),
      ) as _i6.Future<List<_i11.ModelMovie>>);
}

/// A class which mocks [MovieLocalDS].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDS extends _i1.Mock implements _i12.MovieLocalDS {
  MockMovieLocalDS() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<String> addWatchlist(_i13.TableMovie? themovie) =>
      (super.noSuchMethod(
        Invocation.method(
          #addWatchlist,
          [themovie],
        ),
        returnValue: _i6.Future<String>.value(''),
      ) as _i6.Future<String>);
  @override
  _i6.Future<String> deleteWatchlist(_i13.TableMovie? themovie) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteWatchlist,
          [themovie],
        ),
        returnValue: _i6.Future<String>.value(''),
      ) as _i6.Future<String>);
  @override
  _i6.Future<_i13.TableMovie?> getMovieId(int? idMovie) => (super.noSuchMethod(
        Invocation.method(
          #getMovieId,
          [idMovie],
        ),
        returnValue: _i6.Future<_i13.TableMovie?>.value(),
      ) as _i6.Future<_i13.TableMovie?>);
  @override
  _i6.Future<List<_i13.TableMovie>> getWatchlistAllMovie() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistAllMovie,
          [],
        ),
        returnValue:
            _i6.Future<List<_i13.TableMovie>>.value(<_i13.TableMovie>[]),
      ) as _i6.Future<List<_i13.TableMovie>>);
}

/// A class which mocks [DBHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDBHelper extends _i1.Mock implements _i14.DBHelper {
  MockDBHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i15.Database?> get databaseMov => (super.noSuchMethod(
        Invocation.getter(#databaseMov),
        returnValue: _i6.Future<_i15.Database?>.value(),
      ) as _i6.Future<_i15.Database?>);
  @override
  _i6.Future<int> addWatchlistMovie(_i13.TableMovie? themovies) =>
      (super.noSuchMethod(
        Invocation.method(
          #addWatchlistMovie,
          [themovies],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);
  @override
  _i6.Future<int> deleteWatchlistMovie(_i13.TableMovie? themovies) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteWatchlistMovie,
          [themovies],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);
  @override
  _i6.Future<Map<String, dynamic>?> getMoviesId(int? idMovie) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMoviesId,
          [idMovie],
        ),
        returnValue: _i6.Future<Map<String, dynamic>?>.value(),
      ) as _i6.Future<Map<String, dynamic>?>);
  @override
  _i6.Future<List<Map<String, dynamic>>> getWatchlistTheMovie() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTheMovie,
          [],
        ),
        returnValue: _i6.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i6.Future<List<Map<String, dynamic>>>);
  @override
  _i6.Future<int> addWatchlistTVShow(_i16.TableTV? tvShow) =>
      (super.noSuchMethod(
        Invocation.method(
          #addWatchlistTVShow,
          [tvShow],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);
  @override
  _i6.Future<List<Map<String, dynamic>>> getWatchlistTVShow() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTVShow,
          [],
        ),
        returnValue: _i6.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i6.Future<List<Map<String, dynamic>>>);
  @override
  _i6.Future<Map<String, dynamic>?> getTVShowId(int? idTv) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTVShowId,
          [idTv],
        ),
        returnValue: _i6.Future<Map<String, dynamic>?>.value(),
      ) as _i6.Future<Map<String, dynamic>?>);
  @override
  _i6.Future<int> deleteWatchlistTVShow(_i16.TableTV? tvShow) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteWatchlistTVShow,
          [tvShow],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i4.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i4.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<String>.value(''),
      ) as _i6.Future<String>);
  @override
  _i6.Future<_i18.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i18.Uint8List>.value(_i18.Uint8List(0)),
      ) as _i6.Future<_i18.Uint8List>);
  @override
  _i6.Future<_i4.StreamedResponse> send(_i4.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i6.Future<_i4.StreamedResponse>.value(_FakeStreamedResponse_3(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i6.Future<_i4.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}