import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/top_rated_movies_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedAllMoviesPage extends StatefulWidget {
  static const NAME_ROUTE = '/top-rated-movie';

  @override
  _TopRatedAllMoviesPageState createState() => _TopRatedAllMoviesPageState();
}

class _TopRatedAllMoviesPageState extends State<TopRatedAllMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedMoviesNotifier>(context, listen: false)
            .fetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TOP_RATED_MOVIE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedMoviesNotifier>(
          builder: (cntx, dt, chld) {
            if (dt.state == EnumStateRequest.DataLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (dt.state == EnumStateRequest.DataLoaded) {
              return ListView.builder(
                itemBuilder: (cntxt, id) {
                  final movie = dt.movies[id];
                  return MovieCard(movie);
                },
                itemCount: dt.movies.length,
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
}
