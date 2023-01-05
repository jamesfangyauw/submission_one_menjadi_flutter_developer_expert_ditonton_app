import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/popular_all_movies_page.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/all_popular_movies_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([AllPopularMoviesNotifier])
void main() {
  late MockPopularMoviesNotifier mockPopularMoviesNotifier;

  setUp(() {
    mockPopularMoviesNotifier = MockPopularMoviesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<AllPopularMoviesNotifier>.value(
      value: mockPopularMoviesNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when DataLoading',
      (WidgetTester tester) async {
    when(mockPopularMoviesNotifier.enumStateRequest).thenReturn(EnumStateRequest.DataLoading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularAllMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is DataLoaded',
      (WidgetTester tester) async {
    when(mockPopularMoviesNotifier.enumStateRequest).thenReturn(EnumStateRequest.DataLoaded);
    when(mockPopularMoviesNotifier.movies).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularAllMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when DataError',
      (WidgetTester tester) async {
    when(mockPopularMoviesNotifier.enumStateRequest).thenReturn(EnumStateRequest.DataError);
    when(mockPopularMoviesNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularAllMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
