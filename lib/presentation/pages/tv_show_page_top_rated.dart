import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_top_rated_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvShowTopRatedPage extends StatefulWidget {
  static const NAME_ROUTE = '/tv-show-top-rated';

  @override
  _TvShowTopRatedPageState createState() => _TvShowTopRatedPageState();
}

class _TvShowTopRatedPageState extends State<TvShowTopRatedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvShowTopRatedNotifier>(context, listen: false)
            .fetchTopRatedTVShow());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TOP_RATED_TV),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvShowTopRatedNotifier>(
          builder: (ctx, dt, chld) {
            if (dt.tvShowstate == EnumStateRequest.DataLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (dt.tvShowstate == EnumStateRequest.DataLoaded) {
              return ListView.builder(
                itemBuilder: (cont, idx) {
                  final tv = dt.tvShow[idx];
                  return TVCard(tv);
                },
                itemCount: dt.tvShow.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(dt.mssg),
              );
            }
          },
        ),
      ),
    );
  }
}
