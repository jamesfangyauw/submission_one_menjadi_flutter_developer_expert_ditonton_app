import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/top_rated_all_movies_page.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/top_rated_movies_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([TopRatedMoviesNotifier])
void main() {
  late MockTopRatedMoviesNotifier mockTopRatedMoviesNotifier;

  setUp(() {
    mockTopRatedMoviesNotifier = MockTopRatedMoviesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedMoviesNotifier>.value(
      value: mockTopRatedMoviesNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when Dataloading',
      (WidgetTester tester) async {
    when(mockTopRatedMoviesNotifier.state).thenReturn(EnumStateRequest.DataLoading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedAllMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is DataLoaded',
      (WidgetTester tester) async {
    when(mockTopRatedMoviesNotifier.state).thenReturn(EnumStateRequest.DataLoaded);
    when(mockTopRatedMoviesNotifier.movies).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedAllMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when DataError',
      (WidgetTester tester) async {
    when(mockTopRatedMoviesNotifier.state).thenReturn(EnumStateRequest.DataError);
    when(mockTopRatedMoviesNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedAllMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
