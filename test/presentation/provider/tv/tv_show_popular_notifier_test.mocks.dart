// Mocks generated by Mockito 5.3.2 from annotations
// in submission_one_menjadi_flutter_developer_expert_ditonton_app/test/presentation/provider/tv/tv_show_popular_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart'
    as _i6;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart'
    as _i7;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/repositories/tv_show_repo.dart'
    as _i2;
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_popular_tv_show.dart'
    as _i4;

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

class _FakeTVShowRepo_0 extends _i1.SmartFake implements _i2.TVShowRepo {
  _FakeTVShowRepo_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetAllPopularTVShow].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetAllPopularTVShow extends _i1.Mock
    implements _i4.GetAllPopularTVShow {
  MockGetAllPopularTVShow() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVShowRepo get tvShowRepo => (super.noSuchMethod(
        Invocation.getter(#tvShowRepo),
        returnValue: _FakeTVShowRepo_0(
          this,
          Invocation.getter(#tvShowRepo),
        ),
      ) as _i2.TVShowRepo);
  @override
  _i5.Future<
      _i3
          .Either<_i6.FailureEquitable, List<_i7.TVEntities>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue: _i5.Future<
                _i3.Either<_i6.FailureEquitable, List<_i7.TVEntities>>>.value(
            _FakeEither_1<_i6.FailureEquitable, List<_i7.TVEntities>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.FailureEquitable, List<_i7.TVEntities>>>);
}