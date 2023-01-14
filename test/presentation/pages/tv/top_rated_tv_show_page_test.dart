import 'package:bloc_test/bloc_test.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/top_rated_tv_show_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/tv_show_page_top_rated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockTopRatedTVShowCubit extends MockCubit<TopRatedTVShowState> implements TopRatedTVShowCubit {}

void main() {
  late MockTopRatedTVShowCubit mockTopRatedTVShowCubit;

  setUp(() {
    mockTopRatedTVShowCubit = MockTopRatedTVShowCubit();
  });

  Widget _makeTestableWidget(Widget bdy) {
    return MultiProvider(
      providers: [
        BlocProvider<TopRatedTVShowCubit>(
          create: (ctx) => mockTopRatedTVShowCubit,
        ),
      ],
      child: MaterialApp(home: bdy),
    );
  }

  void funcInitial() {
    when(() => mockTopRatedTVShowCubit.fetchTopRatedTVShowCubit()).thenAnswer((_) async => {});
  }

  testWidgets('Page should display center progress bar when enumstaterequest is DataLoading',
          (WidgetTester widgetTester) async {
    funcInitial();

    final fndrPB = find.byType(CircularProgressIndicator);
    final fndrCenter = find.byType(Center);

    when(() => mockTopRatedTVShowCubit.state).thenAnswer((_) => const TopRatedTVShowLoadingState());
    await widgetTester.pumpWidget(_makeTestableWidget(TvShowTopRatedPage()));

    expect(fndrCenter, findsOneWidget);
    expect(fndrPB, findsOneWidget);
  });

  testWidgets('Page should display List View tv vhsow when enumstaterequest is DataLoaded',
          (WidgetTester widgetTester) async {
    /// Find Widget
    final fndrLastView = find.byType(ListView);

    funcInitial();
    when(() => mockTopRatedTVShowCubit.state)
        .thenAnswer((_) => const TopRatedTVShowLoadedState(tvShow: []));

    await widgetTester.pumpWidget(_makeTestableWidget(TvShowTopRatedPage()));

    expect(fndrLastView, findsOneWidget);
  });

  testWidgets('Page should display text with message when enumstaterequest is DataError',
          (WidgetTester widgetTester) async {
    /// Find Widget
    final fndrText = find.byKey(const Key('error_message'));

    funcInitial();
    when(() => mockTopRatedTVShowCubit.state)
        .thenAnswer((_) => const TopRatedTVShowErrorState('error'));

    await widgetTester.pumpWidget(_makeTestableWidget(TvShowTopRatedPage()));

    expect(fndrText, findsOneWidget);
  });
}
