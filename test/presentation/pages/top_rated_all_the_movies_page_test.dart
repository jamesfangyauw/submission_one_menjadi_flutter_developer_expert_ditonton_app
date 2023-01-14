import 'package:bloc_test/bloc_test.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_top_rated_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/top_rated_all_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockAllTheMovieTopRatedCubit extends MockCubit<AllTheMovieTopRatedState> implements AllTheMovieTopRatedCubit {}

void main() {
  late MockAllTheMovieTopRatedCubit mockAllTheMovieTopRatedCubit;

  setUp(() {
    mockAllTheMovieTopRatedCubit = MockAllTheMovieTopRatedCubit();
  });

  Widget _widget(Widget bdy) {
    return MultiProvider(
      providers: [
        BlocProvider<AllTheMovieTopRatedCubit>(
          create: (ctx) => mockAllTheMovieTopRatedCubit,
        ),
      ],
      child: MaterialApp(home: bdy),
    );
  }

  void funcInitial() {
    when(() => mockAllTheMovieTopRatedCubit.fetchAllTheMovieTopRatedCubit()).thenAnswer((_) async => {});
  }

  testWidgets('Page movie should display center progress bar when enumstaterequest is DataLoading',
          (WidgetTester widgetTester) async {
    funcInitial();

    final fndrProgressbar = find.byType(CircularProgressIndicator);
    final fndrCenter = find.byType(Center);

    when(() => mockAllTheMovieTopRatedCubit.state).thenAnswer((_) => const AllTheMovieTopRatedLoadingState());
    await widgetTester.pumpWidget(_widget(const TopRatedAllMoviesPage()));

    expect(fndrCenter, findsOneWidget);
    expect(fndrProgressbar, findsOneWidget);
  });

  testWidgets('Page movie should display List View movie when enumstaterequest is DataLoaded',
          (WidgetTester widgetTester) async {
    /// Find Widget
    final fndrListView = find.byType(ListView);

    funcInitial();
    when(() => mockAllTheMovieTopRatedCubit.state)
        .thenAnswer((_) => const AllTheMovieTopRatedLoadedState(movies: []));

    await widgetTester.pumpWidget(_widget(const TopRatedAllMoviesPage()));

    expect(fndrListView, findsOneWidget);
  });

  testWidgets('Page movie should display text with message when enumstaterequest is DataError',
          (WidgetTester widgetTester) async {
    /// Find Widget
    final fndrText = find.byKey(const Key('error_message'));

    funcInitial();
    when(() => mockAllTheMovieTopRatedCubit.state)
        .thenAnswer((_) => const AllTheMovieTopRatedErrorState('error'));

    await widgetTester.pumpWidget(_widget(const TopRatedAllMoviesPage()));

    expect(fndrText, findsOneWidget);
  });
}
