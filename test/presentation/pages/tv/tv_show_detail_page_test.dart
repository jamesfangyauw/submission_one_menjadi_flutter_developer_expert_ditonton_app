import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/tv_show_detail_page.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_page_test.mocks.dart';

@GenerateMocks([TVShowDetailNotifier])
void main() {
  late tVShowDetailNotifierMock tvShowDetailNotifierMock;

  setUp(() {
    tvShowDetailNotifierMock = tVShowDetailNotifierMock();
  });
  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TVShowDetailNotifier>.value(
      value: tvShowDetailNotifierMock,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist tv show button should display add icon when tv is not added to watchlist',
      (WidgetTester tester) async {
    when(tvShowDetailNotifierMock.tvShowState).thenReturn(EnumStateRequest.DataLoaded);
    when(tvShowDetailNotifierMock.tvDetail).thenReturn(testTVShowDetail);
    when(tvShowDetailNotifierMock.tvShowRecommendationState).thenReturn(EnumStateRequest.DataLoaded);
    when(tvShowDetailNotifierMock.tvShowRecommendations).thenReturn(<TVEntities>[]);
    when(tvShowDetailNotifierMock.tvShowAddedToWatchlist).thenReturn(false);

    final tvShowWatchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TVShowDetailPage(idTv: 1)));

    expect(tvShowWatchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist Tv Show button should dispay check icon when tv is added to wathclist',
      (WidgetTester widgetTester) async {
    when(tvShowDetailNotifierMock.tvShowState).thenReturn(EnumStateRequest.DataLoaded);
    when(tvShowDetailNotifierMock.tvDetail).thenReturn(testTVShowDetail);
    when(tvShowDetailNotifierMock.tvShowRecommendationState).thenReturn(EnumStateRequest.DataLoaded);
    when(tvShowDetailNotifierMock.tvShowRecommendations).thenReturn(<TVEntities>[]);
    when(tvShowDetailNotifierMock.tvShowAddedToWatchlist).thenReturn(true);

    final tvShowWatchlistButtonIcon = find.byIcon(Icons.check);

    await widgetTester.pumpWidget(_makeTestableWidget(TVShowDetailPage(idTv: 1)));

    expect(tvShowWatchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist Tv Show button should display Snackbar when is added to watchlist',
      (WidgetTester tester) async {
    when(tvShowDetailNotifierMock.tvShowState).thenReturn(EnumStateRequest.DataLoaded);
    when(tvShowDetailNotifierMock.tvDetail).thenReturn(testTVShowDetail);
    when(tvShowDetailNotifierMock.tvShowRecommendationState).thenReturn(EnumStateRequest.DataLoaded);
    when(tvShowDetailNotifierMock.tvShowRecommendations).thenReturn(<TVEntities>[]);
    when(tvShowDetailNotifierMock.tvShowAddedToWatchlist).thenReturn(false);
    when(tvShowDetailNotifierMock.tvShowWatchlistMessage).thenReturn('Added to Watchlist');

    final tvShowWatchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TVShowDetailPage(idTv: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(tvShowWatchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist Tv Show button should display AlertDialog when is added to watchlist failed',
      (WidgetTester tester) async {
    when(tvShowDetailNotifierMock.tvShowState).thenReturn(EnumStateRequest.DataLoaded);
    when(tvShowDetailNotifierMock.tvDetail).thenReturn(testTVShowDetail);
    when(tvShowDetailNotifierMock.tvShowRecommendationState).thenReturn(EnumStateRequest.DataLoaded);
    when(tvShowDetailNotifierMock.tvShowRecommendations).thenReturn(<TVEntities>[]);
    when(tvShowDetailNotifierMock.tvShowAddedToWatchlist).thenReturn(false);
    when(tvShowDetailNotifierMock.tvShowWatchlistMessage).thenReturn('Failed');

    final tvShowWatchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TVShowDetailPage(idTv: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(tvShowWatchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
