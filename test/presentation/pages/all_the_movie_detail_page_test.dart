import 'package:bloc_test/bloc_test.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_details_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_recommendations_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/all_movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';


class MockAllTheMovieDetailCubit extends MockCubit<AllTheMovieDetailState> implements AllTheMovieDetailCubit {}

class MockAllTheMovieRecommendationsCubit extends MockCubit<AllTheMovieRecommendationsState>
    implements AllTheMovieRecommendationsCubit {}

void main() {
  late MockAllTheMovieDetailCubit mockAllTheMovieDetailCubit;
  late MockAllTheMovieRecommendationsCubit mockAllTheMovieRecommendationsCubit;

  setUp(() {
    mockAllTheMovieRecommendationsCubit = MockAllTheMovieRecommendationsCubit();
    mockAllTheMovieDetailCubit = MockAllTheMovieDetailCubit();
  });

  Widget _makeTestableWidget(Widget bdy) {
    return MultiProvider(
      providers: [
        BlocProvider<AllTheMovieDetailCubit>(
          create: (ctx) => mockAllTheMovieDetailCubit,
        ),
        BlocProvider<AllTheMovieRecommendationsCubit>(
          create: (ctx) => mockAllTheMovieRecommendationsCubit,
        ),
      ],
      child: MaterialApp(home: bdy),
    );
  }

  void funcInital() {
    when(() => mockAllTheMovieDetailCubit.fetchAllTheMoviesDetailsCubit(any())).thenAnswer((_) async => {});
    when(() => mockAllTheMovieDetailCubit.getWatchlistStatus(any())).thenAnswer((_) async => {});
    when(() => mockAllTheMovieRecommendationsCubit.fetchAllTheMovieRecommendationsCubit(any())).thenAnswer((_) async => {});
  }

  testWidgets('Watchlist movie button should display add icon when movie is not added to watchlist movie',
          (WidgetTester widgetTester) async {
        /// Find widget
        final icnBtnWatchlist = find.byIcon(Icons.add);

        funcInital();

        when(() => mockAllTheMovieDetailCubit.state)
            .thenAnswer((_) => const AllTheMovieDetailState(enumStateRequest: EnumStateRequest.DataLoaded));

        when(() => mockAllTheMovieRecommendationsCubit.state)
            .thenAnswer((_) => AllTheMovieRecommendationsLoadedState(movies: testTheMovieList));

        await widgetTester.pumpWidget(_makeTestableWidget(const AllMovieDetailPage(idMovie: 1)));

        expect(icnBtnWatchlist, findsOneWidget);
      });

  testWidgets('Watchlist movie button should dispay check icon when movie is added to wathclist movie',
          (WidgetTester widgetTester) async {
        /// Find Widget
        final icnBtnWatchlist = find.byIcon(Icons.check);

        funcInital();

        when(() => mockAllTheMovieDetailCubit.state).thenReturn(
          AllTheMovieDetailState(
            enumStateRequest: EnumStateRequest.DataLoaded,
            movieDetail: testTheMovieDetail,
            addToWatchlistIs: true,
          ),
        );

        when(() => mockAllTheMovieRecommendationsCubit.state).thenReturn(
          const AllTheMovieRecommendationsLoadedState(movies: []),
        );

        await widgetTester.pumpWidget(_makeTestableWidget(const AllMovieDetailPage(idMovie: 1)));

        expect(icnBtnWatchlist, findsOneWidget);
      });

  testWidgets('Watchlist movie button should display Snackbar when added to watchlist movie',
          (WidgetTester widgetTester) async {
        funcInital();
        when(() => mockAllTheMovieDetailCubit.addWatchlistTheMovies(testTheMovieDetail)).thenAnswer((_) async => {});

        when(() => mockAllTheMovieDetailCubit.state).thenReturn(
           AllTheMovieDetailState(
            enumStateRequest: EnumStateRequest.DataLoaded,
            movieDetail: testTheMovieDetail,
            mssgWatchlist: 'Added to Watchlist',
          ),
        );

        when(() => mockAllTheMovieRecommendationsCubit.state).thenReturn(
          const AllTheMovieRecommendationsLoadedState(movies: []),
        );

        final btnWatchList = find.byType(ElevatedButton);

        await widgetTester.pumpWidget(_makeTestableWidget(const AllMovieDetailPage(idMovie: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await widgetTester.tap(btnWatchList);
        await widgetTester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
      });

  testWidgets('Watchlist movie button should display AlertDialog when add to watchlist movie error',
          (WidgetTester widgetTester) async {
        funcInital();
        when(() => mockAllTheMovieDetailCubit.addWatchlistTheMovies(testTheMovieDetail)).thenAnswer((_) async => {});

        when(() => mockAllTheMovieDetailCubit.state).thenReturn(
           AllTheMovieDetailState(
            enumStateRequest: EnumStateRequest.DataLoaded,
            movieDetail: testTheMovieDetail,
            mssgWatchlist: 'Failed',
            addToWatchlistIs: false,
          ),
        );

        when(() => mockAllTheMovieRecommendationsCubit.state).thenReturn(
          const AllTheMovieRecommendationsLoadedState(movies: []),
        );

        final btnWatchlist = find.byType(ElevatedButton);

        await widgetTester.pumpWidget(_makeTestableWidget(const AllMovieDetailPage(idMovie: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await widgetTester.tap(btnWatchlist);
        await widgetTester.pump();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Failed'), findsOneWidget);
      });
}
