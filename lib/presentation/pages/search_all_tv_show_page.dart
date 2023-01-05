import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_search_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              onSubmitted: (thequery) {
                Provider.of<TVShowSearchNotifier>(ctx, listen: false)
                    .fetchTVShowSearch(thequery);
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
            Consumer<TVShowSearchNotifier>(
              builder: (cntx, dt, chld) {
                if (dt.tvShowState == EnumStateRequest.DataLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (dt.tvShowState == EnumStateRequest.DataLoaded) {
                  final theresult = dt.tvShowsearchResult;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(1),
                      itemBuilder: (context, index) {
                        final tvshow = dt.tvShowsearchResult[index];
                        return TVCard(tvshow);
                      },
                      itemCount: theresult.length,
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}