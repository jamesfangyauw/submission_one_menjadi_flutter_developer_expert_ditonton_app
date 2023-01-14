import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/top_rated_movies_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/widgets/movie_card_list.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_top_rated_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedAllMoviesPage extends StatefulWidget {
  static const NAME_ROUTE = '/top-rated-movie';
  const TopRatedAllMoviesPage({Key? key}) : super(key: key);

  @override
  _TopRatedAllMoviesPageState createState() => _TopRatedAllMoviesPageState();
}

class _TopRatedAllMoviesPageState extends State<TopRatedAllMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      // Provider.of<TopRatedMoviesNotifier>(ctx, listen: false)
      //     .fetchTopRatedMovies(thequery);
          () => BlocProvider.of<AllTheMovieTopRatedCubit>(context)
              .fetchAllTheMovieTopRatedCubit()
    );
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TOP_RATED_MOVIE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AllTheMovieTopRatedCubit, AllTheMovieTopRatedState>(
          builder: (cntx, stt) {
            if (stt is AllTheMovieTopRatedLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (stt is AllTheMovieTopRatedLoadedState) {
              return ListView.builder(
                itemBuilder: (cntxt, idMovie) {
                  final themovie = stt.movies[idMovie];
                  return MovieCardList(themovie: themovie);
                },
                itemCount: stt.movies.length,
              );
            } else if (stt is AllTheMovieTopRatedErrorState) {
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
}
