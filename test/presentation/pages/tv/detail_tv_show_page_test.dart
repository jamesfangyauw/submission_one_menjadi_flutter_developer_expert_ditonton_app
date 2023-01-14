import 'package:bloc_test/bloc_test.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/detail_tv_show_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/recommendations_tv_show_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/tv_show_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';


class MockDetailTVShowCubit extends MockCubit<DetailTVShowState> implements DetailTVShowCubit {}

class MockRecommendationsTVShowCubit extends MockCubit<RecommendationsTVShowState>
    implements RecommendationsTVShowCubit {}

void main() {
  late MockDetailTVShowCubit mockDetailTVShowCubit;
  late MockRecommendationsTVShowCubit mockRecommendationsTVShowCubit;

  setUp(() {
    mockRecommendationsTVShowCubit = MockRecommendationsTVShowCubit();
    mockDetailTVShowCubit = MockDetailTVShowCubit();
  });

  Widget _makeTestableWidget(Widget bdy) {
    return MultiProvider(
      providers: [
        BlocProvider<DetailTVShowCubit>(
          create: (ctx) => mockDetailTVShowCubit,
        ),
        BlocProvider<RecommendationsTVShowCubit>(
          create: (ctx) => mockRecommendationsTVShowCubit,
        ),
      ],
      child: MaterialApp(home: bdy),
    );
  }

  void funcInital() {
    when(() => mockDetailTVShowCubit.fetchDetailTVShowCubit(any())).thenAnswer((_) async => {});
    when(() => mockDetailTVShowCubit.getWatchlistStatusTVShow(any())).thenAnswer((_) async => {});
    when(() => mockRecommendationsTVShowCubit.fetchRecommendationsTVShowCubit(any())).thenAnswer((_) async => {});
  }

  testWidgets('Watchlist TV Show button should display add icon when tv not added to watchlist tv show',
          (WidgetTester widgetTester) async {
        /// Find widget
        final iconWatchlistAdd = find.byIcon(Icons.add);

        funcInital();

        when(() => mockDetailTVShowCubit.state)
            .thenAnswer((_) => const DetailTVShowState(enumStateRequest: EnumStateRequest.DataLoaded));

        when(() => mockRecommendationsTVShowCubit.state)
            .thenAnswer((_) => RecommendationsTVShowLoadedState(items: testAllTVShowList));

        await widgetTester.pumpWidget(_makeTestableWidget(const TVShowDetailPage(idTv: 1)));

        expect(iconWatchlistAdd, findsOneWidget);
      });

  testWidgets('Watchlist tv show button should dispay check icon when tv is add to wathclist tv show',
          (WidgetTester widgetTester) async {
        /// Find Widget
        final iconWatchlistAdd = find.byIcon(Icons.check);

        funcInital();

        when(() => mockDetailTVShowCubit.state).thenReturn(
          DetailTVShowState(
            enumStateRequest: EnumStateRequest.DataLoaded,
            tvShowDetail: testTVShowDetail,
            addWathclistIs: true,
          ),
        );

        when(() => mockRecommendationsTVShowCubit.state).thenReturn(
          const RecommendationsTVShowLoadedState(items: []),
        );

        await widgetTester.pumpWidget(_makeTestableWidget(const TVShowDetailPage(idTv: 1)));

        expect(iconWatchlistAdd, findsOneWidget);
      });

  testWidgets('Watchlist tv show button should display Snackbar when add to watchlist tv show',
          (WidgetTester widgetTester) async {
        funcInital();
        when(() => mockDetailTVShowCubit.addWatchlistTVShow(testTVShowDetail)).thenAnswer((_) async => {});

        when(() => mockDetailTVShowCubit.state).thenReturn(
           DetailTVShowState(
            enumStateRequest: EnumStateRequest.DataLoaded,
            tvShowDetail: testTVShowDetail,
            mssgWatchlist: 'Added to Watchlist',
          ),
        );

        when(() => mockRecommendationsTVShowCubit.state).thenReturn(
          const RecommendationsTVShowLoadedState(items: []),
        );

        final bttnWatchList = find.byType(ElevatedButton);

        await widgetTester.pumpWidget(_makeTestableWidget(const TVShowDetailPage(idTv: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await widgetTester.tap(bttnWatchList);
        await widgetTester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
      });

  testWidgets('Watchlist tv show button should display AlertDialog when add to watchlist tv show error',
          (WidgetTester widgetTester) async {
        funcInital();
        when(() => mockDetailTVShowCubit.addWatchlistTVShow(testTVShowDetail)).thenAnswer((_) async => {});

        when(() => mockDetailTVShowCubit.state).thenReturn(
           DetailTVShowState(
            enumStateRequest: EnumStateRequest.DataLoaded,
            tvShowDetail: testTVShowDetail,
            mssgWatchlist: 'Failed',
            addWathclistIs: false,
          ),
        );

        when(() => mockRecommendationsTVShowCubit.state).thenReturn(
          const RecommendationsTVShowLoadedState(items: []),
        );

        final bttnWatchList = find.byType(ElevatedButton);

        await widgetTester.pumpWidget(_makeTestableWidget(const TVShowDetailPage(idTv: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await widgetTester.tap(bttnWatchList);
        await widgetTester.pump();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Failed'), findsOneWidget);
      });
}
