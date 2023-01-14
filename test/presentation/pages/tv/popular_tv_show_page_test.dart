import 'package:bloc_test/bloc_test.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/popular_tv_show_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/tv_show_page_popular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';


class MockPopularTVShowCubit extends MockCubit<PopularTVShowState> implements PopularTVShowCubit {}

void main() {
  late MockPopularTVShowCubit mockPopularTVShowCubit;

  setUp(() {
    mockPopularTVShowCubit = MockPopularTVShowCubit();
  });

  Widget _widget(Widget bdy) {
    return MultiProvider(
      providers: [
        BlocProvider<PopularTVShowCubit>(
          create: (ctx) => mockPopularTVShowCubit,
        ),
      ],
      child: MaterialApp(home: bdy),
    );
  }

  void funcInital() {
    when(() => mockPopularTVShowCubit.fetchPopularTVShowCubit()).thenAnswer((_) async => {});
  }

  testWidgets('Page should display center progress bar when enumstaterequest is  DataLoading',
          (WidgetTester widgetTester) async {
    funcInital();

    final fndrProgressBar = find.byType(CircularProgressIndicator);
    final fndrCenter = find.byType(Center);

    when(() => mockPopularTVShowCubit.state).thenAnswer((_) => const PopularTVShowLoadingState());
    await widgetTester.pumpWidget(_widget(TvShowPopularPage()));

    expect(fndrCenter, findsOneWidget);
    expect(fndrProgressBar, findsOneWidget);
  });

  testWidgets('Page should display List View TV Show when enumstaterequest is  DataLoaded',
          (WidgetTester widgetTester) async {
    /// Find Widget
    final fndrListView = find.byType(ListView);

    funcInital();
    when(() => mockPopularTVShowCubit.state)
        .thenAnswer((_) => const PopularTVShowLoadedState(tvShow: []));

    await widgetTester.pumpWidget(_widget(TvShowPopularPage()));

    expect(fndrListView, findsOneWidget);
  });

  testWidgets('Page should display text with message when enumstaterequest is  DataError', (WidgetTester tester) async {
    /// Find Widget
    final fndrText = find.byKey(const Key('error_message'));

    funcInital();
    when(() => mockPopularTVShowCubit.state)
        .thenAnswer((_) => const PopularTVShowErrorState('error'));

    await tester.pumpWidget(_widget(TvShowPopularPage()));

    expect(fndrText, findsOneWidget);
  });
}
