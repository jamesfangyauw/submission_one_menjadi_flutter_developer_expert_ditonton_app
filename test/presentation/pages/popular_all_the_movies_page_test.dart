import 'package:bloc_test/bloc_test.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_popular_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/popular_all_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockAllTheMoviePopularCubit extends MockCubit<AllTheMoviePopularState> implements AllTheMoviePopularCubit {}

void main() {
  late MockAllTheMoviePopularCubit mockAllTheMoviePopularCubit;

  setUp(() {
    mockAllTheMoviePopularCubit = MockAllTheMoviePopularCubit();
  });

  Widget _widget(Widget bdy) {
    return MultiProvider(
      providers: [
        BlocProvider<AllTheMoviePopularCubit>(
          create: (ctx) => mockAllTheMoviePopularCubit,
        ),
      ],
      child: MaterialApp(home: bdy),
    );
  }

  void funcInitial() {
    when(() => mockAllTheMoviePopularCubit.fetchAllThePopularMovieCubit()).thenAnswer((_) async => {});
  }

  testWidgets('Page movie should display center progress bar when enumstaterequest is DataLoading',
          (WidgetTester widgetTester) async {
    funcInitial();

    final fndrProgressBar = find.byType(CircularProgressIndicator);
    final fndrCenter = find.byType(Center);

    when(() => mockAllTheMoviePopularCubit.state).thenAnswer((_) => const AllTheMoviePopularLoadingState());
    await widgetTester.pumpWidget(_widget(const PopularAllMoviesPage()));

    expect(fndrCenter, findsOneWidget);
    expect(fndrProgressBar, findsOneWidget);
  });

  testWidgets('Page movie should display List View movie when  enumstaterequest is DataLoaded',
          (WidgetTester widgetTester) async {
    /// Find Widget
    final fndrLstView = find.byType(ListView);

    funcInitial();
    when(() => mockAllTheMoviePopularCubit.state)
        .thenAnswer((_) => const AllTheMoviePopularLoadedState(movies: []));

    await widgetTester.pumpWidget(_widget(const PopularAllMoviesPage()));

    expect(fndrLstView, findsOneWidget);
  });

  testWidgets('Page should display text with message when  enumstaterequest is DataError',
          (WidgetTester widgetTester) async {
    /// Find Widget
    final fndrText = find.byKey(const Key('error_message'));

    funcInitial();
    when(() => mockAllTheMoviePopularCubit.state)
        .thenAnswer((_) => const AllTheMoviePopularErrorState('error'));

    await widgetTester.pumpWidget(_widget(const PopularAllMoviesPage()));

    expect(fndrText, findsOneWidget);
  });
}
