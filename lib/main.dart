import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/popular_all_movies_page.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/tv_show_page_popular.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/search_movie_tv_show_page.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/utils.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/about_app_page.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/all_movie_detail_page.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/home_tv_show_movie_page.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/tv_show_page_nowplaying.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/top_rated_all_movies_page.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/tv_show_page_top_rated.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/tv_show_detail_page.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/watchlist_all_movie_pages.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/tv_show_page_watchlist.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/all_movie_detail_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/nowplaying_all_movies_page.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/all_movie_list_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/all_movie_search_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/all_popular_movies_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/top_rated_movies_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_nowplay_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_popular_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_top_rated_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_detail_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_list_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_search_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_watchlist_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/watchlist_movie_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/nowplaying_movie_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/injection.dart' as di;

void main() {
  di.init();
  runApp(DitontonApp());
}
class DitontonApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locatorMovieTv<AllMovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locatorMovieTv<AllMovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locatorMovieTv<All_MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locatorMovieTv<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locatorMovieTv<AllPopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locatorMovieTv<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locatorMovieTv<NowPlayingAllMoviesNotifier>(),
        ),
      //  TV Series
        ChangeNotifierProvider(
          create: (_) => di.locatorMovieTv<TVShowListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locatorMovieTv<TVShowDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locatorMovieTv<TVShowSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locatorMovieTv<TvShowTopRatedNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locatorMovieTv<TvShowPopularNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locatorMovieTv<TvShowWatchlistNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locatorMovieTv<TvShowNowPlayingNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo App',
        theme: ThemeData.dark().copyWith(
          colorScheme: pColorScheme,
          primaryColor: black,
          accentColor: pMikadoYellow,
          scaffoldBackgroundColor: black,
          textTheme: pTextTheme,
        ),
        home: HomeTvShowMoviePage(),
        navigatorObservers: [obsrvrRouteUtil],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeTvShowMoviePage());
            case TVShowDetailPage.NAME_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVShowDetailPage(idTv: id),
                settings: settings,
              );
            case TvShowNowplayingPage.NAME_ROUTE:
              return CupertinoPageRoute(builder: (_) => TvShowNowplayingPage());
            case TvShowPopularPage.NAME_ROUTE:
              return CupertinoPageRoute(builder: (_) => TvShowPopularPage());
            case TvShowTopRatedPage.NAME_ROUTE:
              return CupertinoPageRoute(builder: (_) => TvShowTopRatedPage());
            case TvShowWatchlistPage.NAME_ROUTE:
              return MaterialPageRoute(builder: (_) => TvShowWatchlistPage());
            case NowplayingAllMoviePage.NAME_ROUTE:
              return CupertinoPageRoute(builder: (_) => NowplayingAllMoviePage());
            case PopularAllMoviesPage.NAME_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularAllMoviesPage());
            case TopRatedAllMoviesPage.NAME_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedAllMoviesPage());
            case AllMovieDetailPage.NAME_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => AllMovieDetailPage(idtv: id),
                settings: settings,
              );
            case SearchMovieTvShowPage.NAME_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchMovieTvShowPage());
            case WatchlistAllMoviePages.NAME_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistAllMoviePages());
            case AboutAppPage.NAME_ROUTE:
              return MaterialPageRoute(builder: (_) => AboutAppPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found, Try Again'),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
