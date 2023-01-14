import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/search_all_movies.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/search_all_the_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../dummy_data/dummy_objects.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchAllMovies extends Mock implements SearchAllMovies{}
void main() {
  group('SearchAllTheMoviesBloc', () {
    late SearchAllMovies searchAllMovies;

    setUp(() {
      searchAllMovies = MockSearchAllMovies();
    });

    SearchAllTheMoviesBloc blocBld() => SearchAllTheMoviesBloc(searchAllMovies);

    test('correct initial state', () {
      expect(blocBld().state, SearchAllTheMoviesInitial());
    });

    blocTest<SearchAllTheMoviesBloc, SearchAllTheMoviesState>(
      'emits [DataLoading, DataLoaded] when SearchAllTheMoviesAction is successfull.',
      setUp: () {
        when(() => searchAllMovies.execute('endgame'))
            .thenAnswer((_) async => Right(testTheMovieList));
      },
      build: () => blocBld(),
      act: (blocAct) => blocAct.add(const SearchAllTheMoviesAction('endgame')),
      wait: const Duration(milliseconds: 300),
      expect: () => <SearchAllTheMoviesState>[
        SearchAllTheMoviesLoading(),
        SearchAllTheMoviesLoaded(testTheMovieList)
      ],
    );

    blocTest<SearchAllTheMoviesBloc, SearchAllTheMoviesState>(
      'emits [DataLoading, DataError] when SearchAllTheMoviesAction is not success',
      setUp: () {
        when(() => searchAllMovies.execute('endgame'))
            .thenAnswer((_) async =>  Left(FailureServer('Failure')));
      },
      build: () => blocBld(),
      act: (blocAct) => blocAct.add(const SearchAllTheMoviesAction('endgame')),
      wait: const Duration(milliseconds: 300),
      expect: () => <SearchAllTheMoviesState>[
        SearchAllTheMoviesLoading(),
        const SearchAllTheMoviesError('Failure')
      ],
    );

    group('SearchAllTheMoviesEvent', () {
      test('equality', () {
        expect(
          const SearchAllTheMoviesAction('endgame'),
          equals(const SearchAllTheMoviesAction('endgame')),
        );
      });
      test('props correct', () {
        expect(
          const SearchAllTheMoviesAction('endgame').props,
          equals(['endgame']),
        );
      });
    });
  });
}
