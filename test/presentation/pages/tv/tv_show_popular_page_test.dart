import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/tv_show_page_popular.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_popular_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'tv_show_popular_page_test.mocks.dart';

@GenerateMocks([TvShowPopularNotifier])
void main() {
  late PopularTVShowNotifierMock popularTvShowNotifierMock;

  setUp(() {
    popularTvShowNotifierMock = PopularTVShowNotifierMock();
  });

  Widget _makeTestableWidget(Widget widget) {
    return ChangeNotifierProvider<TvShowPopularNotifier>.value(
      value: popularTvShowNotifierMock,
      child: MaterialApp(
        home: widget,
      ),
    );
  }

  testWidgets('Page should display center progress bar when status DataLoading',
      (WidgetTester tester) async {
    when(popularTvShowNotifierMock.stateRequest).thenReturn(EnumStateRequest.DataLoading);

    final finderProgressBar = find.byType(CircularProgressIndicator);
    final finderCenter = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TvShowPopularPage()));

    expect(finderCenter, findsOneWidget);
    expect(finderProgressBar, findsOneWidget);
  });

  testWidgets('Page should display ListView Popular when data status is DataLoaded',
      (WidgetTester tester) async {
    when(popularTvShowNotifierMock.stateRequest).thenReturn(EnumStateRequest.DataLoaded);
    when(popularTvShowNotifierMock.tvShow).thenReturn(<TVEntities>[]);

    final finderListView = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TvShowPopularPage()));

    expect(finderListView, findsOneWidget);
  });

  testWidgets('Page should display text with message error when DataError',
      (WidgetTester tester) async {
    when(popularTvShowNotifierMock.stateRequest).thenReturn(EnumStateRequest.DataError);
    when(popularTvShowNotifierMock.mssg).thenReturn('Error message');

    final errorTextFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TvShowPopularPage()));

    expect(errorTextFinder, findsOneWidget);
  });
}
