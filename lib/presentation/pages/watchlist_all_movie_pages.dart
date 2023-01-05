import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/utils.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/watchlist_movie_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    obsrvrRouteUtil.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
  }

  @override
  Widget build(BuildContext cntx) {
    return Scaffold(
      appBar: AppBar(
        title: Text(WATCHLIST),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistMovieNotifier>(
          builder: (cntxt, dt, chld) {
            if (dt.watchlistState == EnumStateRequest.DataLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (dt.watchlistState == EnumStateRequest.DataLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = dt.watchlistMovies[index];
                  return MovieCard(movie);
                },
                itemCount: dt.watchlistMovies.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(dt.message),
              );
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
