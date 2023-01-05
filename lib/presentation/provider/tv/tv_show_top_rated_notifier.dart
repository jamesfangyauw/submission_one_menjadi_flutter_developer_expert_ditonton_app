import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_top_rated_tv_show.dart';
import 'package:flutter/foundation.dart';

class TvShowTopRatedNotifier extends ChangeNotifier {
  final GetTopRatedTV getTopRatedTVShow;

  TvShowTopRatedNotifier({required this.getTopRatedTVShow});

  EnumStateRequest _tvShowstate = EnumStateRequest.DataEmpty;
  EnumStateRequest get tvShowstate => _tvShowstate;

  List<TVEntities> _tvShow = [];
  List<TVEntities> get tvShow => _tvShow;

  String _mssg = '';
  String get mssg => _mssg;

  Future<void> fetchTopRatedTVShow() async {
    _tvShowstate = EnumStateRequest.DataLoading;
    notifyListeners();

    final theresult = await getTopRatedTVShow.execute();

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
    _tvShowstate = EnumStateRequest.DataError;
    notifyListeners();
  }

  void _tvShowData(tvShowData){
    _tvShow = tvShowData;
    _tvShowstate = EnumStateRequest.DataLoaded;
    notifyListeners();
  }
}
