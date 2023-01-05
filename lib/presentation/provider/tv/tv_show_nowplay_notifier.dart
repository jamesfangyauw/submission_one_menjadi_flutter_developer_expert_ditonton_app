import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_now_playing_tv_show.dart';
import 'package:flutter/foundation.dart';

class TvShowNowPlayingNotifier extends ChangeNotifier {
  final GetAllNowPlayingTVShow getAllNowPlayingTVShow;

  TvShowNowPlayingNotifier({required this.getAllNowPlayingTVShow});
  EnumStateRequest _tvShowState = EnumStateRequest.DataEmpty;
  EnumStateRequest get tvShowState => _tvShowState;

  List<TVEntities> _tvShow = [];
  List<TVEntities> get tvShow => _tvShow;

  String _mssg = '';
  String get mssg => _mssg;

  Future<void> fetchNowPlayingtvShow() async {
    _tvShowState = EnumStateRequest.DataLoading;
    notifyListeners();

    final theresult = await getAllNowPlayingTVShow.execute();

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
    _mssg = failureTv.mssg;
    _tvShowState = EnumStateRequest.DataError;
    notifyListeners();
  }

  void _tvShowData(tvShowData){
    _tvShow = tvShowData;
    _tvShowState = EnumStateRequest.DataLoaded;
    notifyListeners();
  }
}
