import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_now_playing_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_popular_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_top_rated_tv_show.dart';
import 'package:flutter/material.dart';

class TVShowListNotifier extends ChangeNotifier {
  var _tvShowNowPlaying = <TVEntities>[];
  List<TVEntities> get tvShowNowPlaying => _tvShowNowPlaying;

  EnumStateRequest _tvShowNowPlayingState = EnumStateRequest.DataEmpty;
  EnumStateRequest get tvShowNowPlayingState => _tvShowNowPlayingState;

  var _tvShowpopular = <TVEntities>[];
  List<TVEntities> get tvShowpopular => _tvShowpopular;

  EnumStateRequest _tvShowpopularTVState = EnumStateRequest.DataEmpty;
  EnumStateRequest get tvShowpopularTVState => _tvShowpopularTVState;

  var _tvShowtopRated = <TVEntities>[];
  List<TVEntities> get tvShowtopRatedTV => _tvShowtopRated;

  EnumStateRequest _tvShowtopRatedState = EnumStateRequest.DataEmpty;
  EnumStateRequest get tvShowtopRatedTVState => _tvShowtopRatedState;

  String _mssg = '';
  String get mssg => _mssg;

  TVShowListNotifier({
    required this.getAllNowPlayingTVShow,
    required this.getAllPopularTVShow,
    required this.getAllTopRatedTVShow,
  });

  final GetAllNowPlayingTVShow getAllNowPlayingTVShow;
  final GetAllPopularTVShow getAllPopularTVShow;
  final GetTopRatedTV getAllTopRatedTVShow;

  Future<void> fetchNowPlayingTVShow() async {
    _tvShowNowPlayingState = EnumStateRequest.DataLoading;
    notifyListeners();

    final theresult = await getAllNowPlayingTVShow.execute();
    theresult.fold(
      (failureTv) {
        _failureNowPlaying(failureTv);
      },
      (tvShowData) {
        _tvShowDataNowPlaying(tvShowData);
      },
    );
  }

  Future<void> fetchPopularTVShow() async {
    _tvShowpopularTVState = EnumStateRequest.DataLoading;
    notifyListeners();

    final theresult = await getAllPopularTVShow.execute();
    theresult.fold(
      (failureTv) {
        _failurePopular(failureTv);
      },
      (tvShowData) {
        _tvShowDataPopular(tvShowData);
      },
    );
  }

  Future<void> fetchTopRatedTVShow() async {
    _tvShowtopRatedState = EnumStateRequest.DataLoading;
    notifyListeners();

    final theresult = await getAllTopRatedTVShow.execute();
    theresult.fold(
      (failureTv) {
        _failureTopRated(failureTv);
      },
      (tvShowData) {
        _tvShowDataTopRated(tvShowData);
      },
    );
  }

  void _failureNowPlaying(failureTv){
    _tvShowNowPlayingState = EnumStateRequest.DataError;
    _mssg = failureTv.mssg;
    notifyListeners();
  }

  void _tvShowDataNowPlaying(tvShowData){
    _tvShowNowPlayingState = EnumStateRequest.DataLoaded;
    _tvShowNowPlaying = tvShowData;
    notifyListeners();
  }

  void _failurePopular(failureTv){
    _tvShowpopularTVState = EnumStateRequest.DataError;
    _mssg = failureTv.mssg;
    notifyListeners();
  }
  void _tvShowDataPopular(tvShowData){
    _tvShowpopularTVState = EnumStateRequest.DataLoaded;
    _tvShowpopular = tvShowData;
    notifyListeners();
  }
  void _failureTopRated(failureTv){
    _tvShowtopRatedState = EnumStateRequest.DataError;
    _mssg = failureTv.mssg;
    notifyListeners();
  }
  void _tvShowDataTopRated(tvShowData){
    _tvShowtopRatedState = EnumStateRequest.DataLoaded;
    _tvShowtopRated = tvShowData;
    notifyListeners();
  }
}
