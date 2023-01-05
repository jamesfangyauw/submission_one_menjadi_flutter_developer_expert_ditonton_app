import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_tv_show_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_tv_show_recommendations.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_watchlist_tv_show_status.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/remove_all_watchlist_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/save_all_watchlist_tv_show.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TVShowDetailNotifier extends ChangeNotifier {
  static const watchlistTvShowAddSuccessMessage = 'Added to Watchlist';
  static const watchlistTvShowRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVShowRecommendations getAllTVShowRecommendations;
  final RemoveAllWatchlistTVShow removeAllTvShowWatchlist;
  final GetAllWatchListStatusTVShow getAllTVShowWatchListStatus;
  final GetAllTVShowDetail getAllTVShowDetail;
  final SaveAllWatchlistTVShow saveAllTVShowWatchlist;


  TVShowDetailNotifier({
    required this.getAllTVShowDetail,
    required this.getAllTVShowRecommendations,
    required this.getAllTVShowWatchListStatus,
    required this.saveAllTVShowWatchlist,
    required this.removeAllTvShowWatchlist,
  });

  late TVShowDetail _tvDetail;
  TVShowDetail get tvDetail => _tvDetail;

  EnumStateRequest _tvShowState = EnumStateRequest.DataEmpty;
  EnumStateRequest get tvShowState => _tvShowState;

  List<TVEntities> _tvShowRecommendations = [];
  List<TVEntities> get tvShowRecommendations => _tvShowRecommendations;

  EnumStateRequest _tvShowRecommendationState = EnumStateRequest.DataEmpty;
  EnumStateRequest get tvShowRecommendationState => _tvShowRecommendationState;

  String _mssg = '';
  String get mssg => _mssg;

  bool _tvShowAddedtoWatchlist = false;
  bool get tvShowAddedToWatchlist => _tvShowAddedtoWatchlist;

  Future<void> fetchTVDetail(int idTvShow) async {
    _tvShowState = EnumStateRequest.DataLoading;
    notifyListeners();
    final resultDetail = await getAllTVShowDetail.execute(idTvShow);
    final resultRecomendation = await getAllTVShowRecommendations.execute(idTvShow);
    resultDetail.fold(
      (failureTv) {
        _failure(failureTv);
      },
      (tvShow) {
        _tvShow(tvShow);
        resultRecomendation.fold(
          (failureTv) {
            _failureTvs(failureTv);
          },
          (tvsShow) {
            _tvsShow(tvsShow);
          },
        );
        _tvShowState = EnumStateRequest.DataLoaded;
        notifyListeners();
      },
    );
  }

  String _tvShowWatchlistMessage = '';
  String get tvShowWatchlistMessage => _tvShowWatchlistMessage;

  Future<void> addWatchlistTvShow(TVShowDetail tvDetail) async {
    final theresult = await saveAllTVShowWatchlist.execute(tvDetail);

    await theresult.fold(
      (failureTv) async {
        _tvShowWatchlistMessage = failureTv.mssg;
      },
      (successMssg) async {
        _tvShowWatchlistMessage = successMssg;
      },
    );

    await tvShowLoadWatchlistStatus(tvDetail.tvShowId);
  }

  Future<void> removeFromWatchlist(TVShowDetail tv) async {
    final theresult = await removeAllTvShowWatchlist.execute(tv);

    await theresult.fold(
      (failureTv) async {
        _tvShowWatchlistMessage = failureTv.mssg;
      },
      (successMssg) async {
        _tvShowWatchlistMessage = successMssg;
      },
    );

    await tvShowLoadWatchlistStatus(tv.tvShowId);
  }

  Future<void> tvShowLoadWatchlistStatus(int idTv) async {
    final theresult = await getAllTVShowWatchListStatus.execute(idTv);
    _tvShowAddedtoWatchlist = theresult;
    notifyListeners();
  }

  void _resutlDetail(resultDetail, resultRecomendation, _tvShowState){
    resultDetail.fold(
          (failureTv) {
        _tvShowState = EnumStateRequest.DataError;
        _mssg = failureTv.mssg;
        notifyListeners();
      },
          (tvShow) {
        _tvShowRecommendationState = EnumStateRequest.DataLoading;
        _tvDetail = tvShow;
        notifyListeners();
        resultRecomendation.fold(
              (failureTv) {
            _tvShowRecommendationState = EnumStateRequest.DataError;
            _mssg = failureTv.mssg;
          },
              (tvsShow) {
            _tvShowRecommendationState = EnumStateRequest.DataLoaded;
            _tvShowRecommendations = tvsShow;
          },
        );
        _tvShowState = EnumStateRequest.DataLoaded;
        notifyListeners();
      },
    );
  }
  void _failure(failureTv){
    _tvShowState = EnumStateRequest.DataError;
    _mssg = failureTv.mssg;
    notifyListeners();
  }
  void _tvShow(tvShow){
    _tvShowRecommendationState = EnumStateRequest.DataLoading;
    _tvDetail = tvShow;
    notifyListeners();
  }
  void _failureTvs(failureTv){
    _tvShowRecommendationState = EnumStateRequest.DataError;
    _mssg = failureTv.mssg;
  }
  void _tvsShow (tvsShow){
    _tvShowRecommendationState = EnumStateRequest.DataLoaded;
    _tvShowRecommendations = tvsShow;
  }
}
