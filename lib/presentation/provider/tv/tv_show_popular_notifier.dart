import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_popular_tv_show.dart';
import 'package:flutter/foundation.dart';

class TvShowPopularNotifier extends ChangeNotifier {
  final GetAllPopularTVShow getAllPopularTVShow;
  TvShowPopularNotifier(this.getAllPopularTVShow);

  EnumStateRequest _tvShowstateRequest = EnumStateRequest.DataEmpty;
  EnumStateRequest get stateRequest => _tvShowstateRequest;

  List<TVEntities> _tvShow = [];
  List<TVEntities> get tvShow => _tvShow;

  String _mssg = '';
  String get mssg => _mssg;

  Future<void> fetchPopularTVShow() async {
    _tvShowstateRequest = EnumStateRequest.DataLoading;
    notifyListeners();

    final theresult = await getAllPopularTVShow.execute();

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
    _tvShowstateRequest = EnumStateRequest.DataError;
    notifyListeners();
  }

  void _tvShowData(tvShowData){
    _tvShow = tvShowData;
    _tvShowstateRequest = EnumStateRequest.DataLoaded;
    notifyListeners();
  }
}
