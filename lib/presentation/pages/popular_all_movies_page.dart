import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/all_popular_movies_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/widgets/movie_card_list.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_popular_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PopularAllMoviesPage extends StatefulWidget {
  static const NAME_ROUTE = '/popular-movie';
  const PopularAllMoviesPage({Key? key}) : super(key: key);

  @override
  _PopularAllMoviesPageState createState() => _PopularAllMoviesPageState();
}

class _PopularAllMoviesPageState extends State<PopularAllMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        // Provider.of<AllPopularMoviesNotifier>(context, listen: false)
        //     .fetchPopularMovies());
        () => BlocProvider.of<AllTheMoviePopularCubit>(context)
            .fetchAllThePopularMovieCubit());
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(POPULAR_MOVIE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: Consumer<AllPopularMoviesNotifier>(
        //   builder: (cntx, dt, chld) {
        //     if (dt.enumStateRequest == EnumStateRequest.DataLoading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (dt.enumStateRequest == EnumStateRequest.DataLoaded) {
        child: BlocBuilder<AllTheMoviePopularCubit, AllTheMoviePopularState>(
          builder: (cntxt, stt) {
            if (stt is AllTheMoviePopularLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (stt is AllTheMoviePopularLoadedState) {
              return ListView.builder(
                itemBuilder: (cntext, idx) {
                  final themovie = stt.movies[idx];
                  return MovieCardList(themovie: themovie);
                },
                itemCount: stt.movies.length,
              );
            } else if (stt is AllTheMoviePopularErrorState) {
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
