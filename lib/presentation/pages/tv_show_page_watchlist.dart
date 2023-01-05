import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/utils.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_watchlist_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvShowWatchlistPage extends StatefulWidget {
  static const NAME_ROUTE = '/tv-show-watchlist';

  @override
  _TvShowWatchlistPageState createState() => _TvShowWatchlistPageState();
}

class _TvShowWatchlistPageState extends State<TvShowWatchlistPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvShowWatchlistNotifier>(context, listen: false)
            .fetchWatchlistTVShow());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    obsrvrRouteUtil.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<TvShowWatchlistNotifier>(context, listen: false)
        .fetchWatchlistTVShow();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(WATCHLIST),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvShowWatchlistNotifier>(
          builder: (ctx, dt, chld) {
            if (dt.tvShowwatchlistState == EnumStateRequest.DataLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (dt.tvShowwatchlistState == EnumStateRequest.DataLoaded) {
              return ListView.builder(
                itemBuilder: (cntxt, idx) {
                  final movie = dt.tvShowWatchlist[idx];
                  return TVCard(movie);
                },
                itemCount: dt.tvShowWatchlist.length,
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

  void dispose() {
    obsrvrRouteUtil.unsubscribe(this);
    super.dispose();
  }
}
