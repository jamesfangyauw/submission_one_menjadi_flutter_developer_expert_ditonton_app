import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/search_all_tv_show.dart';
import 'package:flutter/foundation.dart';

class TVShowSearchNotifier extends ChangeNotifier {
  final SearchAllTVShow searchallTvShow;
  TVShowSearchNotifier({required this.searchallTvShow});

  EnumStateRequest _tvShowstate = EnumStateRequest.DataEmpty;
  EnumStateRequest get tvShowState => _tvShowstate;

  List<TVEntities> _tvShowsearchResult = [];
  List<TVEntities> get tvShowsearchResult => _tvShowsearchResult;

  String _mssg = '';
  String get mssg => _mssg;

  Future<void> fetchTVShowSearch(String query) async {
    _tvShowstate = EnumStateRequest.DataLoading;
    notifyListeners();

    final theresult = await searchallTvShow.execute(query);
    theresult.fold(
      (failureTv) {
        _failureTv(failureTv);
      },
      (tvShowdata) {
        _tvShowData(tvShowdata);
      },
    );
  }

  void _failureTv(failureTv){
    _mssg = failureTv.mssg;
    _tvShowstate = EnumStateRequest.DataError;
    notifyListeners();
  }

  void _tvShowData(tvShowdata){
    _tvShowsearchResult = tvShowdata;
    _tvShowstate = EnumStateRequest.DataLoaded;
    notifyListeners();
  }
}
