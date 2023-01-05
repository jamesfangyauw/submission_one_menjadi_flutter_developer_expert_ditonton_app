import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/datasources/db/db_helper.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/datasources/movie_local_ds.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/datasources/movie_remote_ds.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/repositories/movie_repo_impl.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/repositories/movie_repo.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_movie_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_movie_recommendations.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_now_playing_movies.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_popular_movies.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_top_rated_movies.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_watchlist_movies.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_watchlist_status.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/remove_all_watchlist.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/save_all_watchlist.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/search_all_movies.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/all_movie_detail_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/nowplaying_movie_notifier.dart';
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
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'data/datasources/tv_local_ds.dart';
import 'data/datasources/tv_remote_ds.dart';
import 'data/repositories/tvshow_repo_impl.dart';
import 'domain/repositories/tv_show_repo.dart';
import 'domain/usecases/tv/get_all_now_playing_tv_show.dart';
import 'domain/usecases/tv/get_all_popular_tv_show.dart';
import 'domain/usecases/tv/get_all_top_rated_tv_show.dart';
import 'domain/usecases/tv/get_all_tv_show_detail.dart';
import 'domain/usecases/tv/get_all_tv_show_recommendations.dart';
import 'domain/usecases/tv/get_all_watchlist_tv_show.dart';
import 'domain/usecases/tv/get_all_watchlist_tv_show_status.dart';
import 'domain/usecases/tv/remove_all_watchlist_tv_show.dart';
import 'domain/usecases/tv/save_all_watchlist_tv_show.dart';
import 'domain/usecases/tv/search_all_tv_show.dart';
final locatorMovieTv = GetIt.instance;
void init() {
  locatorMovieTv.registerFactory(
    () => AllMovieListNotifier(
      getNowPlayingMovies: locatorMovieTv(),
      getPopularMovies: locatorMovieTv(),
      getTopRatedMovies: locatorMovieTv(),
    ),
  );
  locatorMovieTv.registerFactory(
    () => AllMovieDetailNotifier(
      getMovieDetail: locatorMovieTv(),
      getMovieRecommendations: locatorMovieTv(),
      getWatchListStatus: locatorMovieTv(),
      saveWatchlist: locatorMovieTv(),
      removeWatchlist: locatorMovieTv(),
    ),
  );
  locatorMovieTv.registerFactory(
    () => All_MovieSearchNotifier(
      searchMovies: locatorMovieTv(),
    ),
  );
  locatorMovieTv.registerFactory(
    () => AllPopularMoviesNotifier(
      locatorMovieTv(),
    ),
  );
  locatorMovieTv.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locatorMovieTv(),
    ),
  );
  locatorMovieTv.registerFactory(
        () => NowPlayingAllMoviesNotifier(
      getAllNowPlayingMovies: locatorMovieTv(),
    ),
  );
  locatorMovieTv.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locatorMovieTv(),
    ),
  );
  locatorMovieTv.registerFactory(
        () => TVShowListNotifier(
      getAllNowPlayingTVShow: locatorMovieTv(),
      getAllPopularTVShow: locatorMovieTv(),
      getAllTopRatedTVShow: locatorMovieTv(),
    ),
  );
  locatorMovieTv.registerFactory(
        () => TVShowDetailNotifier(
      getAllTVShowDetail: locatorMovieTv(),
      getAllTVShowRecommendations: locatorMovieTv(),
      getAllTVShowWatchListStatus: locatorMovieTv(),
      saveAllTVShowWatchlist: locatorMovieTv(),
      removeAllTvShowWatchlist: locatorMovieTv(),
    ),
  );
  locatorMovieTv.registerFactory(
        () => TVShowSearchNotifier(
      searchallTvShow: locatorMovieTv(),
    ),
  );
  locatorMovieTv.registerFactory(
        () => TvShowPopularNotifier(
      locatorMovieTv(),
    ),
  );
  locatorMovieTv.registerFactory(
        () => TvShowTopRatedNotifier(
      getTopRatedTVShow: locatorMovieTv(),
    ),
  );
  locatorMovieTv.registerFactory(
        () => TvShowNowPlayingNotifier(
      getAllNowPlayingTVShow: locatorMovieTv(),
    ),
  );
  locatorMovieTv.registerFactory(
        () => TvShowWatchlistNotifier(
      getAllWatchlistTVShow: locatorMovieTv(),
    ),
  );

  locatorMovieTv.registerLazySingleton(() => GetAllNowPlayingMovies(locatorMovieTv()));
  locatorMovieTv.registerLazySingleton(() => GetAllPopularMovies(locatorMovieTv()));
  locatorMovieTv.registerLazySingleton(() => GetAllTopRatedMovies(locatorMovieTv()));
  locatorMovieTv.registerLazySingleton(() => GetAllMovieDetail(locatorMovieTv()));
  locatorMovieTv.registerLazySingleton(() => GetAllMovieRecommendations(locatorMovieTv()));
  locatorMovieTv.registerLazySingleton(() => SearchAllMovies(locatorMovieTv()));
  locatorMovieTv.registerLazySingleton(() => GetAllWatchListTvShowStatus(locatorMovieTv()));
  locatorMovieTv.registerLazySingleton(() => SaveAllWatchlistTvShow(locatorMovieTv()));
  locatorMovieTv.registerLazySingleton(() => RemoveAllWatchlistTvShow(locatorMovieTv()));
  locatorMovieTv.registerLazySingleton(() => GetAllWatchlistMovies(locatorMovieTv()));

  locatorMovieTv.registerLazySingleton(() => GetAllNowPlayingTVShow(locatorMovieTv()));
  locatorMovieTv.registerLazySingleton(() => GetAllPopularTVShow(locatorMovieTv()));
  locatorMovieTv.registerLazySingleton(() => GetTopRatedTV(locatorMovieTv()));
  locatorMovieTv.registerLazySingleton(() => GetAllTVShowDetail(locatorMovieTv()));
  locatorMovieTv.registerLazySingleton(() => GetTVShowRecommendations(locatorMovieTv()));
  locatorMovieTv.registerLazySingleton(() => SearchAllTVShow(locatorMovieTv()));
  locatorMovieTv.registerLazySingleton(() => GetAllWatchListStatusTVShow(locatorMovieTv()));
  locatorMovieTv.registerLazySingleton(() => SaveAllWatchlistTVShow(locatorMovieTv()));
  locatorMovieTv.registerLazySingleton(() => RemoveAllWatchlistTVShow(locatorMovieTv()));
  locatorMovieTv.registerLazySingleton(() => GetAllWatchlistTVShow(locatorMovieTv()));

  locatorMovieTv.registerLazySingleton<MovieRepository>(
    () => MovieRepoImpl(
      movieRemoteDS: locatorMovieTv(),
      movieLocalDS: locatorMovieTv(),
    ),
  );

  locatorMovieTv.registerLazySingleton<TVShowRepo>(
        () => TVShowRepoImpl(
          tvRemoteDS: locatorMovieTv(),
          tvLocalDS: locatorMovieTv(),
    ),
  );

  locatorMovieTv.registerLazySingleton<MovieRemoteDS>(
      () => MovieRemoteDataSourceImpl(clientHTTP: locatorMovieTv()));
  locatorMovieTv.registerLazySingleton<MovieLocalDS>(
      () => MovieLocalDSImpl(dbHelper: locatorMovieTv()));

  locatorMovieTv.registerLazySingleton<TVRemoteDS>(
          () => TVShowRemoteDSImpl(clientHTTP: locatorMovieTv()));
  locatorMovieTv.registerLazySingleton<TVLocalDS>(
          () => TVLocalDataSourceImpl(dbHelper: locatorMovieTv()));

  locatorMovieTv.registerLazySingleton<DBHelper>(() => DBHelper());

  locatorMovieTv.registerLazySingleton(() => http.Client());
}
