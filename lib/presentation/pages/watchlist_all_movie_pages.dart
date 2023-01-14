import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/utils.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/watchlist_movie_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/widgets/movie_card_list.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_watchlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistAllMoviePages extends StatefulWidget {
  static const NAME_ROUTE = '/movie-watchlist';

  @override
  _WatchlistAllMoviePagesState createState() => _WatchlistAllMoviePagesState();
}

class _WatchlistAllMoviePagesState extends State<WatchlistAllMoviePages>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        //     () =>
        // Provider.of<WatchlistMovieNotifier>(context, listen: false)
        //     .fetchWatchlistMovies()
          () => BlocProvider.of<AllTheMovieWatchlistCubit>(context).fetchAllTheMovieWatchlistCubit(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    obsrvrRouteUtil.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    // Provider.of<WatchlistMovieNotifier>(context, listen: false)
    //     .fetchWatchlistMovies();
    BlocProvider.of<AllTheMovieWatchlistCubit>(context).fetchAllTheMovieWatchlistCubit();
  }

  @override
  Widget build(BuildContext cntx) {
    return Scaffold(
      appBar: AppBar(
        title: Text(WATCHLIST),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: Consumer<WatchlistMovieNotifier>(
        //   builder: (cntxt, dt, chld) {
        //     if (dt.watchlistState == EnumStateRequest.DataLoading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (dt.watchlistState == EnumStateRequest.DataLoaded) {
        child:
        BlocBuilder<AllTheMovieWatchlistCubit, AllTheMovieWatchlistState>(
          builder: (cntxt, stt) {
            if (stt is AllTheMovieWatchlistLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (stt is AllTheMovieWatchlistLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final themovie = stt.movies[index];
                  return MovieCardList(themovie: themovie);
                },
                itemCount: stt.movies.length,
              );
            } else if (stt is AllTheMovieWatchlistErrorState) {
              return Center(
                key: const Key('error_message'),
                child: Text(stt.mssg),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  void dispose() {
    obsrvrRouteUtil.unsubscribe(this);
    super.dispose();
  }
}
