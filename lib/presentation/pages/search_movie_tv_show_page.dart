import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/search_all_movies_page.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/search_all_tv_show_page.dart';
import 'package:flutter/material.dart';

class SearchMovieTvShowPage extends StatelessWidget {
  const SearchMovieTvShowPage({super.key});
  static const NAME_ROUTE = '/search-movie-tv-show';

  @override
  Widget build(BuildContext ctx) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search Movie-TV'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.movie_creation_outlined),
              ),
              Tab(
                icon: Icon(Icons.live_tv_rounded),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SearchAllMoviesPage(),
            SearchAllTvShowPage(),
          ],
        ),
      ),
    );
  }
}















