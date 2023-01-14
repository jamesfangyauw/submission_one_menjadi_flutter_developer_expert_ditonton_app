import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/now_playing_tv_show_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_nowplay_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvShowNowplayingPage extends StatefulWidget {
  static const NAME_ROUTE = '/tv-show-playing-now';

  @override
  _TvShowNowplayingPageState createState() => _TvShowNowplayingPageState();
}

class _TvShowNowplayingPageState extends State<TvShowNowplayingPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
          () => BlocProvider.of<NowPlayingTVShowCubit>(context).fetchNowPlayingTVShowCubit()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(NOW_PLAYING_TV),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: Consumer<TvShowNowPlayingNotifier>(
        //   builder: (ctx, dt, chld) {
        //     if (dt.tvShowState == EnumStateRequest.DataLoading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (dt.tvShowState == EnumStateRequest.DataLoaded) {
        child: BlocBuilder<NowPlayingTVShowCubit, NowPlayingTVShowState>(
          builder: (cntxt, stt) {
            if (stt is NowPlayingTVShowLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (stt is NowPlayingTVShowLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = stt.tvShow[index];
                  return TVCardList(tvEntities : tvShow);
                },
                itemCount: stt.tvShow.length,
              );
            } else if (stt is NowPlayingTVShowErrorState) {
              return Center(
                key: const Key('error_message'),
                child: Text(stt.mssg,
              ));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
