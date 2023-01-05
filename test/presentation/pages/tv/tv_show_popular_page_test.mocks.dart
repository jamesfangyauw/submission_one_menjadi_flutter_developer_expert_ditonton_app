// Mocks generated by Mockito 5.0.8 from annotations
// in submission_one_menjadi_flutter_developer_expert_ditonton_app/test/presentation/pages/tv_show_popular_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:ui' as _i7;

import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart' as _i4;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart' as _i5;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_popular_tv_show.dart' as _i2;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_popular_notifier.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeGetAllPopularTVShow extends _i1.Fake implements _i2.GetAllPopularTVShow {}

/// A class which mocks [PopularTVNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class PopularTVShowNotifierMock extends _i1.Mock
    implements _i3.TvShowPopularNotifier {
  PopularTVShowNotifierMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetAllPopularTVShow get getAllPopularTVShow =>
      (super.noSuchMethod(Invocation.getter(#getPopularTV),
          returnValue: _FakeGetAllPopularTVShow()) as _i2.GetAllPopularTVShow);
  @override
  _i4.EnumStateRequest get stateRequest => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _i4.EnumStateRequest.DataEmpty) as _i4.EnumStateRequest);
  @override
  List<_i5.TVEntities> get tvShow => (super.noSuchMethod(Invocation.getter(#tv),
      returnValue: <_i5.TVEntities>[]) as List<_i5.TVEntities>);
  @override
  String get mssg =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i6.Future<void> fetchPopularTVShow() =>
      (super.noSuchMethod(Invocation.method(#fetchPopularTV, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i6.Future<void>);
  @override
  void addListener(_i7.VoidCallback? listenerTv) =>
      super.noSuchMethod(Invocation.method(#addListener, [listenerTv]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i7.VoidCallback? listenerTv) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listenerTv]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}
