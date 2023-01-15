import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/search_tv_show_bloc.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_search_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';



class SearchAllTvShowPage extends StatelessWidget {
  static const NAME_ROUTE = '/search-tv-show-page';
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
                // FirebaseCrashlytics.instance.crash();
                // Provider.of<TVShowSearchNotifier>(ctx, listen: false)
                //     .fetchTVShowSearch(thequery);
                BlocProvider.of<SearchTVShowBloc>(ctx)
                    .add(SearchTVShowAction(thequery));

              },
              decoration: InputDecoration(
                hintText: TV_SEARCH,
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
            // Consumer<TVShowSearchNotifier>(
            //   builder: (cntx, dt, chld) {
            //     if (dt.tvShowState == EnumStateRequest.DataLoading) {
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (dt.tvShowState == EnumStateRequest.DataLoaded) {
            //       final theresult = dt.tvShowsearchResult;
            //       return Expanded(
            //         child: ListView.builder(
            //           padding: const EdgeInsets.all(1),
            //           itemBuilder: (context, index) {
            //             final tvshow = dt.tvShowsearchResult[index];
            //             return TVCard(tvshow);
            //           },
            //           itemCount: theresult.length,
            //         ),
            BlocBuilder<SearchTVShowBloc, SearchTVShowState>(
              builder: (cntxt, stt) {
                if (stt is SearchTVShowLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (stt is SearchTVShowLoaded) {
                  return Expanded(
                      child: ListView.builder(
                    itemBuilder: (cntx, idx) {
                      final themovie = stt.tvShow[idx];
                      return TVCardList(tvEntities: themovie);
                    },
                    itemCount: stt.tvShow.length,
                  ));
                } else if (stt is SearchTVShowError) {
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