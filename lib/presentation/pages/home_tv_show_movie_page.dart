import 'package:cached_network_image/cached_network_image.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/URL_BASE.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/now_playing_tv_show_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/popular_tv_show_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/top_rated_tv_show_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/about_app_page.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/all_movie_detail_page.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/popular_all_movies_page.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/tv_show_page_popular.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/search_movie_tv_show_page.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/top_rated_all_movies_page.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/tv_show_page_top_rated.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/tv_show_detail_page.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/watchlist_all_movie_pages.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/tv_show_page_watchlist.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/all_movie_list_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_list_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_now_playing_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_popular_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_top_rated_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'nowplaying_all_movies_page.dart';
import 'tv_show_page_nowplaying.dart';

class HomeTvShowMoviePage extends StatefulWidget {
  static const NAME_ROUTE = '/homw-pages-movie-tv-app';
  const HomeTvShowMoviePage({Key? key}) : super(key: key);

  @override
  _HomeTvShowMoviePageState createState() => _HomeTvShowMoviePageState();
}

class _HomeTvShowMoviePageState extends State<HomeTvShowMoviePage> {
  int _bttmNavIdx = 0;

  final List<Widget> _wdgetLst = [
    const HomeAllTheMoviesPages(),
    const HomeAllTvShowPage(),
  ];

  final List<BottomNavigationBarItem> _navigationBarBttmItms = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.movie),
      label: MOVIE.toUpperCase(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.tv),
      label: TVSHOW.toUpperCase(),
    ),
  ];

  void _onBottomNavTapped(int idx) {
    setState(() {
      _bttmNavIdx = idx;
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      drawer: Drawer(
        child: _buildDrawer(ctx),
      ),
      appBar: AppBar(
        title: const Text(TITLE),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(ctx, SearchMovieTvShowPage.NAME_ROUTE,
                  arguments: (_bttmNavIdx == 0) ? MOVIE : TVSHOW);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: _wdgetLst[_bttmNavIdx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bttmNavIdx,
        items: _navigationBarBttmItms,
        onTap: _onBottomNavTapped,
        selectedItemColor: Colors.lightGreenAccent,
      ),
    );
  }

  Widget _buildDrawer(BuildContext ctx) {
    return Column(
      children: [
        const UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage(ASSET),
          ),
          accountName: Text(NAME),
          accountEmail: Text(EMAIL),
        ),
        ListTile(
          leading: const Icon(Icons.movie_creation_rounded),
          title: const Text(MOVIE),
          onTap: () {
            _onBottomNavTapped(0);
            Navigator.pop(ctx);
          },
        ),
        ListTile(
          leading: const Icon(Icons.live_tv_rounded),
          title: const Text(TVSHOW),
          onTap: () {
            _onBottomNavTapped(1);
            Navigator.pop(ctx);
          },
        ),
        ListTile(
          leading: Icon(Icons.save_alt),
          title: Text(MOVIE + ' '+ WATCHLIST),
          onTap: () {
            Navigator.pushNamed(ctx, WatchlistAllMoviePages.NAME_ROUTE);
          },
        ),
        ListTile(
          leading: Icon(Icons.save_alt_sharp),
          title: Text(TVSHOW + ' ' + WATCHLIST),
          onTap: () {
            Navigator.pushNamed(ctx, TvShowWatchlistPage.NAME_ROUTE);
          },
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(ctx, AboutAppPage.NAME_ROUTE);
          },
          leading: const Icon(Icons.info_outline_rounded),
          title: const Text(ABOUT),
        ),
      ],
    );
  }
}

class HomeAllTheMoviesPages extends StatefulWidget {
  const HomeAllTheMoviesPages({Key? keyTheMovie}) : super(key: keyTheMovie);

  @override
  _HomeAllTheMoviesPagesState createState() => _HomeAllTheMoviesPagesState();
}

class _HomeAllTheMoviesPagesState extends State<HomeAllTheMoviesPages> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(
    //         () => Provider.of<AllMovieListNotifier>(context, listen: false)
    //       ..fetchNowPlayingMovies()
    //       ..fetchPopularMovies()
    //       ..fetchTopRatedMovies()
    // );
    Future.microtask(() {
      BlocProvider.of<AllTheMovieNowPlayingCubit>(context).fetchAllTheMovieNowPlayingCubit();
      BlocProvider.of<AllTheMoviePopularCubit>(context).fetchAllThePopularMovieCubit();
      BlocProvider.of<AllTheMovieTopRatedCubit>(context).fetchAllTheMovieTopRatedCubit();
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubHeading(
              ttle: NOW_PLAYING_MOVIE,
              tap: () =>
                  Navigator.pushNamed(ctx, NowplayingAllMoviePage.NAME_ROUTE),
            ),
            // Consumer<AllMovieListNotifier>(builder: (cntx, dt, chld) {
            //   final thestate = dt.nowPlayingState;
            //   if (thestate == EnumStateRequest.DataLoading) {
            //     return Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   } else if (thestate == EnumStateRequest.DataLoaded) {
            //     return MovieList(dt.nowPlayingMovies);
            //   } else {
            //     return Text('Failed');
            //   }
            // }),
            BlocBuilder<AllTheMovieNowPlayingCubit, AllTheMovieNowPlayingState>(
              builder: (cntxt, stt) {
                if (stt is AllTheMovieNowPlayingLoadingState) {
                  return const  CircularProgressIndicator();
                } else if (stt is AllTheMovieNowPlayingLoadedState) {
                  return MovieList(themovies : stt.movies);
                } else if (stt is AllTheMovieNowPlayingErrorState) {
                  return  Text(stt.mssg);
                } else {
                  return Container();
                }
              },
            ),
            _buildSubHeading(
              ttle: POPULAR_MOVIE,
              tap: () =>
                  Navigator.pushNamed(ctx, PopularAllMoviesPage.NAME_ROUTE),
            ),
            // Consumer<AllMovieListNotifier>(builder: (cntx, dt, chld) {
            //   final thestate = dt.popularMoviesState;
            //   if (thestate == EnumStateRequest.DataLoading) {
            //     return Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   } else if (thestate == EnumStateRequest.DataLoaded) {
            //     return MovieList(dt.popularMovies);
            //   } else {
            //     return Text('Failed');
            //   }
            // }),
            BlocBuilder<AllTheMoviePopularCubit, AllTheMoviePopularState>(
              builder: (context, state) {
                if (state is AllTheMoviePopularLoadingState) {
                  return CircularProgressIndicator();
                } else if (state is AllTheMoviePopularLoadedState) {
                  return MovieList(themovies : state.movies);
                } else if (state is AllTheMoviePopularErrorState) {
                  return Text(state.mssg);
                } else {
                  return Container();
                }
              },
            ),
            _buildSubHeading(
              ttle: TOP_RATED_MOVIE,
              tap: () =>
                  Navigator.pushNamed(ctx, TopRatedAllMoviesPage.NAME_ROUTE),
            ),
            // Consumer<AllMovieListNotifier>(builder: (cntx, dt, chld) {
            //   final thestate = dt.topRatedMoviesState;
            //   if (thestate == EnumStateRequest.DataLoading) {
            //     return Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   } else if (thestate == EnumStateRequest.DataLoaded) {
            //     return MovieList(dt.topRatedMovies);
            //   } else {
            //     return Text('Failed');
            //   }
            // })
            BlocBuilder<AllTheMovieTopRatedCubit, AllTheMovieTopRatedState>(
              builder: (context, state) {
                if (state is AllTheMovieTopRatedLoadingState) {
                  return CircularProgressIndicator();
                } else if (state is AllTheMovieTopRatedLoadedState) {
                  return MovieList(themovies : state.movies);
                } else if (state is AllTheMovieTopRatedErrorState) {
                  return Text(state.mssg);
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  Row _buildSubHeading({required String ttle, required Function() tap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          ttle,
          style: pHeading6,
        ),
        InkWell(
          onTap: tap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text(MORE), Icon(Icons.arrow_forward_ios_sharp)],
            ),
          ),
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////

class HomeAllTvShowPage extends StatefulWidget {
  const HomeAllTvShowPage({Key? keyTvShow}) : super(key: keyTvShow);

  @override
  _HomeAllTvShowPageState createState() => _HomeAllTvShowPageState();
}

class _HomeAllTvShowPageState extends State<HomeAllTvShowPage> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(
    //         () =>
    //     Provider.of<TVShowListNotifier>(context, listen: false)
    //       ..fetchNowPlayingTVShow()
    //       ..fetchPopularTVShow()
    //       ..fetchTopRatedTVShow()
    // );
    Future.microtask(() {
      BlocProvider.of<NowPlayingTVShowCubit>(context).fetchNowPlayingTVShowCubit();
      BlocProvider.of<PopularTVShowCubit>(context).fetchPopularTVShowCubit();
      BlocProvider.of<TopRatedTVShowCubit>(context).fetchTopRatedTVShowCubit();
    });
  }

    @override
    Widget build(BuildContext ctx) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                ttle: NOW_PLAYING_TV,
                tap: () =>
                    Navigator.pushNamed(ctx, TvShowNowplayingPage.NAME_ROUTE),
              ),
              // Consumer<TVShowListNotifier>(builder: (cntxt, dt, chld) {
              //   final thestate = dt.tvShowNowPlayingState;
              //   if (thestate == EnumStateRequest.DataLoading) {
              //     return Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   } else if (thestate == EnumStateRequest.DataLoaded) {
              //     return TVShowList(dt.tvShowNowPlaying);
              //   } else {
              //     return Text('Failed');
              //   }
              // }),
              BlocBuilder<NowPlayingTVShowCubit, NowPlayingTVShowState>(
                builder: (cntxt, stt) {
                  if (stt is NowPlayingTVShowLoadingState) {
                    return  CircularProgressIndicator();
                  } else if (stt is NowPlayingTVShowLoadedState) {
                    return TVShowList(tvShow : stt.tvShow);
                  } else if (stt is NowPlayingTVShowErrorState) {
                    return  Text(stt.mssg);
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                ttle: POPULAR_TV,
                tap: () =>
                    Navigator.pushNamed(ctx, TvShowPopularPage.NAME_ROUTE),
              ),
              // Consumer<TVShowListNotifier>(builder: (cntxt, dt, chld) {
              //   final thestate = dt.tvShowpopularTVState;
              //   if (thestate == EnumStateRequest.DataLoading) {
              //     return Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   } else if (thestate == EnumStateRequest.DataLoaded) {
              //     return TVShowList(dt.tvShowpopular);
              //   } else {
              //     return Text('Failed');
              //   }
              // }),
              BlocBuilder<PopularTVShowCubit, PopularTVShowState>(
                builder: (cntxt, stt) {
                  if (stt is PopularTVShowLoadingState) {
                    return CircularProgressIndicator();
                  } else if (stt is PopularTVShowLoadedState) {
                    return TVShowList(tvShow : stt.tvShow);
                  } else if (stt is PopularTVShowErrorState) {
                    return Text(stt.mssg);
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                ttle: TOP_RATED_TV,
                tap: () =>
                    Navigator.pushNamed(ctx, TvShowTopRatedPage.NAME_ROUTE),
              ),
              // Consumer<TVShowListNotifier>(builder: (cntx, dt, chld) {
              //   final thestate = dt.tvShowtopRatedTVState;
              //   if (thestate == EnumStateRequest.DataLoading) {
              //     return Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   } else if (thestate == EnumStateRequest.DataLoaded) {
              //     return TVShowList(dt.tvShowtopRatedTV);
              //   } else {
              //     return Text('Failed');
              //   }
              // }),
              BlocBuilder<TopRatedTVShowCubit, TopRatedTVShowState>(
                builder: (context, state) {
                  if (state is TopRatedTVShowLoadingState) {
                    return CircularProgressIndicator();
                  } else if (state is TopRatedTVShowLoadedState) {
                    return TVShowList(tvShow : state.tvShow);
                  } else if (state is TopRatedTVShowErrorState) {
                    return  Text(state.mssg);
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      );
    }

    Row _buildSubHeading({required String ttle, required Function() tap}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ttle,
            style: pHeading6,
          ),
          InkWell(
            onTap: tap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [Text(MORE), Icon(Icons.arrow_forward_ios_rounded)],
              ),
            ),
          ),
        ],
      );
    }
  }

class MovieList extends StatelessWidget {
  final List<Movie> themovies;
  // MovieList(this.themovies);
  const MovieList({Key? key, required this.themovies}) : super(key: key);

  Widget build(BuildContext ctx) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = themovies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AllMovieDetailPage.NAME_ROUTE,
                  arguments: movie.idMovie,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$URL_BASE_IMAGE${movie.posterPathMovie}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: themovies.length,
      ),
    );
  }
}

class TVShowList extends StatelessWidget {
  final List<TVEntities> tvShow;
  const TVShowList({Key? key, required this.tvShow}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final allTvShow = tvShow[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVShowDetailPage.NAME_ROUTE,
                  arguments: allTvShow.idTv,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$URL_BASE_IMAGE${allTvShow.path_poster}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvShow.length,
      ),
    );
  }
}