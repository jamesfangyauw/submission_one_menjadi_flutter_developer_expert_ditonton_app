import 'package:bloc_test/bloc_test.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/now_playing_tv_show_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/tv_show_page_nowplaying.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/color.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/utils.dart';

import '../../../dummy_data/dummy_objects.dart';


class MockNowPlayingTVShowCubit extends MockCubit<NowPlayingTVShowState>
    implements NowPlayingTVShowCubit {}

void main() {
  group('NowPlayingTVShowPage', () {
    late NowPlayingTVShowCubit nowPlayingTVShowCubit;

    setUp(() {
      nowPlayingTVShowCubit = MockNowPlayingTVShowCubit();
    });

    Widget widget(Widget bdy) {
      return BlocProvider.value(
        value: nowPlayingTVShowCubit,
        child: materialSetUp(widget: bdy),
      );
    }

    void cubitFake() {
      when(() => nowPlayingTVShowCubit.fetchNowPlayingTVShowCubit()).thenAnswer((_) async {});
    }

    testWidgets('Page should display center progress bar when enumstaterequest is DataLoading',
            (WidgetTester widgetTester) async {
          cubitFake();
          when(() => nowPlayingTVShowCubit.state).thenReturn(NowPlayingTVShowLoadingState());

          final fndrProgressBar = find.byType(CircularProgressIndicator);
          final fndrCenter = find.byType(Center);

          await widgetTester.pumpWidget(widget( TvShowNowplayingPage()));

          expect(fndrCenter, findsOneWidget);
          expect(fndrProgressBar, findsOneWidget);
        });

    testWidgets('Page should display List TV Show when enumstaterequest is DataLoaded',
            (WidgetTester widgetTester) async {
          cubitFake();
          when(() => nowPlayingTVShowCubit.state)
              .thenReturn(NowPlayingTVShowLoadedState(tvShow: testAllTVShowList));

          final fndrListView = find.byType(ListView);

          await widgetTester.pumpWidget(widget(TvShowNowplayingPage()));

          expect(fndrListView, findsOneWidget);
        });

    testWidgets('Page should display text with message when enumstaterequest is DataError',
            (WidgetTester widgetTester) async {
          cubitFake();
          when(() => nowPlayingTVShowCubit.state)
              .thenReturn(const NowPlayingTVShowErrorState('Error message'));

          final fndrText = find.byKey(const Key('error_message'));

          await widgetTester.pumpWidget(widget(TvShowNowplayingPage()));

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
