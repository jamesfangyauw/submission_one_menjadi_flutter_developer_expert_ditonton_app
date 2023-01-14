import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/nowplaying_movie_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/widgets/movie_card_list.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_now_playing_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class NowplayingAllMoviePage extends StatefulWidget {
  static const NAME_ROUTE = '/playing-movie';

  @override
  _NowplayingAllMoviePageState createState() => _NowplayingAllMoviePageState();
}

class _NowplayingAllMoviePageState extends State<NowplayingAllMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        // Provider.of<NowPlayingAllMoviesNotifier>(context, listen: false)
        //     .fetchNowPlayingAllMovies());
          () => BlocProvider.of<AllTheMovieNowPlayingCubit>(context)
              .fetchAllTheMovieNowPlayingCubit(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(NOW_PLAYING_MOVIE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: Consumer<NowPlayingAllMoviesNotifier>(
        //   builder: (ctx, dt, chld) {
        //     if (dt.enumStateRequest == EnumStateRequest.DataLoading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (dt.enumStateRequest == EnumStateRequest.DataLoaded) {
        child: BlocBuilder<AllTheMovieNowPlayingCubit, AllTheMovieNowPlayingState>(
          builder: (context, state) {
            if (state is AllTheMovieNowPlayingLoadingState) {
              return const Center(child:CircularProgressIndicator());
            } else if (state is AllTheMovieNowPlayingLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return MovieCardList(themovie:movie);
                },
                itemCount: state.movies.length,
              );
            } else if (state is AllTheMovieNowPlayingErrorState) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.mssg),
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
