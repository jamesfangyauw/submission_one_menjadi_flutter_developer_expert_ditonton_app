import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/search_all_the_movies_bloc.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/all_movie_search_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAllMoviesPage extends StatelessWidget {
  static const NAME_ROUTE = '/search-movie-page';
  String? searching;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (thequery) {
                // Provider.of<All_MovieSearchNotifier>(ctx, listen: false)
                //     .fetchMovieSearch(thequery);
                BlocProvider.of<SearchAllTheMoviesBloc>(ctx)
                    .add(SearchAllTheMoviesAction(thequery));
              },
              decoration: InputDecoration(
                hintText: MOVIE_SEARCH,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 5.0),
              ),
              textInputAction: TextInputAction.search,
            ),

            Text(
              SEARCH_RESULT,
              style: pHeading6,
            ),
            // Consumer<All_MovieSearchNotifier>(
            //   builder: (cntx, dt, chld) {
            //     if (dt.state == EnumStateRequest.DataLoading) {
            //       return Center(
            //         child: CircularProgressIndicator(),
            BlocBuilder<SearchAllTheMoviesBloc, SearchAllTheMoviesState>(
              builder: (cntxt, stt) {
                if (stt is SearchAllTheMoviesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (stt is SearchAllTheMoviesLoaded) {
                  return Expanded(
                      child: ListView.builder(
                    itemBuilder: (cntx, idx) {
                      final themovie = stt.themovies[idx];
                      return MovieCardList(themovie: themovie);
                    },
                    itemCount: stt.themovies.length,
                  ));
                // } else if (dt.state == EnumStateRequest.DataLoaded) {
                //   final result = dt.searchResult;
                //   return Expanded(
                //     child: ListView.builder(
                //       padding: const EdgeInsets.all(1),
                //       itemBuilder: (cntxt, idx) {
                //         final themovie = dt.searchResult[idx];
                //         return MovieCard(themovie);
                //       },
                //       itemCount: result.length,
                //     ),
                } else if (stt is SearchAllTheMoviesError) {
                  return Center(
                    key: const Key('error_message'),
                    child: Text(stt.mssg),
                  );
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
}