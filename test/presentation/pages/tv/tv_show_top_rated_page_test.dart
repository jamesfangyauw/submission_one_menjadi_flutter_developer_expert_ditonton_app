import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/tv_show_page_top_rated.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_top_rated_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'tv_show_top_rated_page_test.mocks.dart';

@GenerateMocks([TvShowTopRatedNotifier])
void main() {
  late AllTopRatedTVNotifierMock allTopRatedTvNotifierMock;

  setUp(() {
    allTopRatedTvNotifierMock = AllTopRatedTVNotifierMock();
  });

  Widget _makeTestableWidget(Widget widget) {
    return ChangeNotifierProvider<TvShowTopRatedNotifier>.value(
      value: allTopRatedTvNotifierMock,
      child: MaterialApp(
        home: widget,
      ),
    );
  }

  testWidgets('Page should display progress bar status when Dataloading',
      (WidgetTester tester) async {
    when(allTopRatedTvNotifierMock.tvShowstate).thenReturn(EnumStateRequest.DataLoading);

    final finderProgressbar = find.byType(CircularProgressIndicator);
    final finderCenter = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TvShowTopRatedPage()));

    expect(finderCenter, findsOneWidget);
    expect(finderProgressbar, findsOneWidget);
  });


  testWidgets('Page should display text with message error when DataError',
      (WidgetTester tester) async {
    when(allTopRatedTvNotifierMock.tvShowstate).thenReturn(EnumStateRequest.DataError);
    when(allTopRatedTvNotifierMock.mssg).thenReturn('Error message');

    final findertext = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TvShowTopRatedPage()));

    expect(findertext, findsOneWidget);
  });

  testWidgets('Page should display when data status is Dataloaded',
          (WidgetTester tester) async {
        when(allTopRatedTvNotifierMock.tvShowstate).thenReturn(EnumStateRequest.DataLoaded);
        when(allTopRatedTvNotifierMock.tvShow).thenReturn(<TVEntities>[]);

        final finderlistView = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(TvShowTopRatedPage()));

        expect(finderlistView, findsOneWidget);
      });

}
