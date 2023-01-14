import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/search_all_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/search_tv_show_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockSearchAllTVShow extends Mock implements SearchAllTVShow {}

void main() {
  group('Search TV Show Bloc', () {
    late SearchAllTVShow searchAllTVShow;

    setUp(() {
      searchAllTVShow = MockSearchAllTVShow();
    });

    SearchTVShowBloc blocBld() => SearchTVShowBloc(searchAllTVShow);

    test('correct initial state', () {
      expect(blocBld().state, SearchTVShowInitial());
    });

    blocTest<SearchTVShowBloc, SearchTVShowState>(
      'emits [DataLoading, DataLoaded] when Search TV Show is successfull.',
      setUp: () {
        when(() => searchAllTVShow.execute('query'))
            .thenAnswer((_) async => Right(testAllTVShowList));
      },
      build: () => blocBld(),
      act: (blocAct) => blocAct.add(const SearchTVShowAction('query')),
      wait: const Duration(milliseconds: 300),
      expect: () => <SearchTVShowState>[
        SearchTVShowLoading(),
        SearchTVShowLoaded(testAllTVShowList)
      ],
    );

    blocTest<SearchTVShowBloc, SearchTVShowState>(
      'emits [DataLoading, DataError] when Search TV Show is not success',
      setUp: () {
        when(() => searchAllTVShow.execute('query'))
            .thenAnswer((_) async => Left(FailureServer('Failure')));
      },
      build: () => blocBld(),
      act: (blocAct) => blocAct.add(const SearchTVShowAction('query')),
      wait: const Duration(milliseconds: 300),
      expect: () => <SearchTVShowState>[
        SearchTVShowLoading(),
        const SearchTVShowError('Failure')
      ],
    );
  });

  group('SearchTVShowEvent', () {
    test('equality', () {
      expect(
        const SearchTVShowAction('query'),
        equals(const SearchTVShowAction('query')),
      );
    });
    test('props correct', () {
      expect(
        const SearchTVShowAction('query').props,
        equals(['query']),
      );
    });
  });
}
