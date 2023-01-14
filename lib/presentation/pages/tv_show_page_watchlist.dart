import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/utils.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/watchlist_tv_show_cubit.dart';
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
    // Future.microtask(() =>
    //     Provider.of<TvShowWatchlistNotifier>(context, listen: false)
    //         .fetchWatchlistTVShow());
    Future.microtask(
          () => BlocProvider.of<WatchlistTVShowCubit>(context).fetchWatchlistTVShowCubit(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    obsrvrRouteUtil.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    // Provider.of<TvShowWatchlistNotifier>(context, listen: false)
    //     .fetchWatchlistTVShow();
    BlocProvider.of<WatchlistTVShowCubit>(context).fetchWatchlistTVShowCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(WATCHLIST),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: Consumer<TvShowWatchlistNotifier>(
        //   builder: (ctx, dt, chld) {
        //     if (dt.tvShowwatchlistState == EnumStateRequest.DataLoading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (dt.tvShowwatchlistState == EnumStateRequest.DataLoaded) {
        child: BlocBuilder<WatchlistTVShowCubit, WatchlistTVShowState>(
          builder: (cntx, stt) {
            if (stt is WatchlistLoadingTVShowState) {
              return const Center(child: CircularProgressIndicator());
            } else if (stt is WatchlistTVShowLoadedState) {
              return ListView.builder(
                itemBuilder: (cntxt, idx) {
                  final tvShow = stt.tvShow[idx];
                  return TVCardList(tvEntities: tvShow);
                },
                itemCount: stt.tvShow.length,
              );
            } else if (stt is WatchlistTVShowErrorState){
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

  void dispose() {
    obsrvrRouteUtil.unsubscribe(this);
    super.dispose();
  }
}
