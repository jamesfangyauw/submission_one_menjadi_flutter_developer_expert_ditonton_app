import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
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
    Future.microtask(() =>
        Provider.of<TvShowPopularNotifier>(context, listen: false)
            .fetchPopularTVShow());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(POPULAR_TV),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvShowPopularNotifier>(
          builder: (ctx, dt, chld) {
            if (dt.stateRequest == EnumStateRequest.DataLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (dt.stateRequest == EnumStateRequest.DataLoaded) {
              return ListView.builder(
                itemBuilder: (cntxt, idx) {
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
