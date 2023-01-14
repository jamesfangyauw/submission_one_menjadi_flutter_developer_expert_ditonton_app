import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/popular_tv_show_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_popular_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvShowPopularPage extends StatefulWidget {
  static const NAME_ROUTE = '/tv-show-popular';

  @override
  _TvShowPopularPageState createState() => _TvShowPopularPageState();
}

class _TvShowPopularPageState extends State<TvShowPopularPage> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(() =>
    //     Provider.of<TvShowPopularNotifier>(context, listen: false)
    //         .fetchPopularTVShow());
    Future.microtask(
          () => BlocProvider.of<PopularTVShowCubit>(context).fetchPopularTVShowCubit()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(POPULAR_TV),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: Consumer<TvShowPopularNotifier>(
        //   builder: (ctx, dt, chld) {
        //     if (dt.stateRequest == EnumStateRequest.DataLoading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (dt.stateRequest == EnumStateRequest.DataLoaded) {
        child: BlocBuilder<PopularTVShowCubit, PopularTVShowState>(
          builder: (cntx, stt) {
            if (stt is PopularTVShowLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (stt is PopularTVShowLoadedState) {
              return ListView.builder(
                itemBuilder: (cntxt, idx) {
                  final tvShow = stt.tvShow[idx];
                  return TVCardList(tvEntities: tvShow);
                },
                itemCount: stt.tvShow.length,
              );
            } else if (stt is PopularTVShowErrorState) {
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
