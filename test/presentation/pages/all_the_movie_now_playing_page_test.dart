import 'package:bloc_test/bloc_test.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_now_playing_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/nowplaying_all_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/color.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/utils.dart';
import 'package:flutter/material.dart';

import '../../dummy_data/dummy_objects.dart';


class MockAllTheMovieNowPlayingCubit extends MockCubit<AllTheMovieNowPlayingState>
    implements AllTheMovieNowPlayingCubit {}

void main() {
  group('NowPlayingAllTheMoviesPage', () {
    late AllTheMovieNowPlayingCubit allTheMovieNowPlayingCubit;

    setUp(() {
      allTheMovieNowPlayingCubit = MockAllTheMovieNowPlayingCubit();
    });

    Widget makeTestableWidget(Widget bdy) {
      return BlocProvider.value(
        value: allTheMovieNowPlayingCubit,
        child: materialSetUp(widget: bdy),
      );
    }

    void cubitFake() {
      when(() => allTheMovieNowPlayingCubit.fetchAllTheMovieNowPlayingCubit()).thenAnswer((_) async {});
    }

    testWidgets('Page movie should display center progress bar when enumstaterequest is  DataLoading',
            (WidgetTester widgetTester) async {
          cubitFake();
          when(() => allTheMovieNowPlayingCubit.state).thenReturn(AllTheMovieNowPlayingLoadingState());

          final fndrProgressBar = find.byType(CircularProgressIndicator);
          final fndrCenter = find.byType(Center);

          await widgetTester.pumpWidget(makeTestableWidget( NowplayingAllMoviePage()));

          expect(fndrCenter, findsOneWidget);
          expect(fndrProgressBar, findsOneWidget);
        });

    testWidgets('Page movie should display List View movie  when enumstaterequest is  DataLoaded',
            (WidgetTester widgetTester) async {
          cubitFake();
          when(() => allTheMovieNowPlayingCubit.state)
              .thenReturn(AllTheMovieNowPlayingLoadedState(movies: testTheMovieList));

          final fndrLstView = find.byType(ListView);

          await widgetTester.pumpWidget(makeTestableWidget(NowplayingAllMoviePage()));

          expect(fndrLstView, findsOneWidget);
        });

    testWidgets('Page movie should display text with message when enumstaterequest is  DataError',
            (WidgetTester widgetTester) async {
          cubitFake();
          when(() => allTheMovieNowPlayingCubit.state)
              .thenReturn(const AllTheMovieNowPlayingErrorState('Error message'));

          final fndrText = find.byKey(const Key('error_message'));

          await widgetTester.pumpWidget(makeTestableWidget(NowplayingAllMoviePage()));

          expect(fndrText, findsOneWidget);
        });
  });
}


MaterialApp materialSetUp({Widget? widget}) {
  return MaterialApp(
    theme: ThemeData.dark().copyWith(
      colorScheme: pColorScheme,
      primaryColor: black,
      scaffoldBackgroundColor: black,
      textTheme: pTextTheme,
    ),
    navigatorObservers: [obsrvrRouteUtil],
    home: widget,
  );
}
