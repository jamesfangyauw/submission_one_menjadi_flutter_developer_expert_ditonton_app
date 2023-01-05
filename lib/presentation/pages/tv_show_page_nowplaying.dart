import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
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
    Future.microtask(() =>
        Provider.of<TvShowNowPlayingNotifier>(context, listen: false)
            .fetchNowPlayingtvShow());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(NOW_PLAYING_TV),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvShowNowPlayingNotifier>(
          builder: (ctx, dt, chld) {
            if (dt.tvShowState == EnumStateRequest.DataLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (dt.tvShowState == EnumStateRequest.DataLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = dt.tvShow[index];
                  return TVCard(tvShow);
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
