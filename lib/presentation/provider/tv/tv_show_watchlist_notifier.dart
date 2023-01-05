import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_watchlist_tv_show.dart';
import 'package:flutter/foundation.dart';

class TvShowWatchlistNotifier extends ChangeNotifier {
  var _tvShowwatchlist = <TVEntities>[];
  List<TVEntities> get tvShowWatchlist => _tvShowwatchlist;

  var _tvShowwatchlistState = EnumStateRequest.DataEmpty;
  EnumStateRequest get tvShowwatchlistState => _tvShowwatchlistState;

  String _mssg = '';
  String get mssg => _mssg;

  TvShowWatchlistNotifier({required this.getAllWatchlistTVShow});

  final GetAllWatchlistTVShow getAllWatchlistTVShow;

  Future<void> fetchWatchlistTVShow() async {
    _tvShowwatchlistState = EnumStateRequest.DataLoading;
    notifyListeners();

    final theresult = await getAllWatchlistTVShow.execute();
    theresult.fold(
      (failureTv) {
        _failureTv(failureTv);
      },
      (tvShowData) {
        _tvShowData(tvShowData);
      },
    );
  }

  void _failureTv(failureTv){
    _tvShowwatchlistState = EnumStateRequest.DataError;
    _mssg = failureTv.mssg;
    notifyListeners();
  }

  void _tvShowData(tvShowData){
    _tvShowwatchlistState = EnumStateRequest.DataLoaded;
    _tvShowwatchlist = tvShowData;
    notifyListeners();
  }
}
