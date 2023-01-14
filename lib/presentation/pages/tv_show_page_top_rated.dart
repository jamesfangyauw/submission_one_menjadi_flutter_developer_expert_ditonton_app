import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/top_rated_tv_show_cubit.dart';
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
    // Future.microtask(() =>
    //     Provider.of<TvShowTopRatedNotifier>(context, listen: false)
    //         .fetchTopRatedTVShow());
    Future.microtask(
          () => BlocProvider.of<TopRatedTVShowCubit>(context).fetchTopRatedTVShowCubit()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TOP_RATED_TV),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: Consumer<TvShowTopRatedNotifier>(
        //   builder: (ctx, dt, chld) {
        //     if (dt.tvShowstate == EnumStateRequest.DataLoading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (dt.tvShowstate == EnumStateRequest.DataLoaded) {
        child: BlocBuilder<TopRatedTVShowCubit, TopRatedTVShowState>(
          builder: (cntx, stt) {
            if (stt is TopRatedTVShowLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (stt is TopRatedTVShowLoadedState) {
              return ListView.builder(
                itemBuilder: (cont, idx) {
                  final tvShow = stt.tvShow[idx];
                  return TVCardList(tvEntities: tvShow,);
                },
                itemCount: stt.tvShow.length,
              );
            } else if (stt is TopRatedTVShowErrorState) {
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
