import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/all_popular_movies_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularAllMoviesPage extends StatefulWidget {
  static const NAME_ROUTE = '/popular-movie';

  @override
  _PopularAllMoviesPageState createState() => _PopularAllMoviesPageState();
}

class _PopularAllMoviesPageState extends State<PopularAllMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<AllPopularMoviesNotifier>(context, listen: false)
            .fetchPopularMovies());
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text(POPULAR_MOVIE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<AllPopularMoviesNotifier>(
          builder: (cntx, dt, chld) {
            if (dt.enumStateRequest == EnumStateRequest.DataLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (dt.enumStateRequest == EnumStateRequest.DataLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = dt.movies[index];
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
