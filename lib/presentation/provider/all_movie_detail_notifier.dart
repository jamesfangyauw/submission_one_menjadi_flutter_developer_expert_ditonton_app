import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_movie_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_movie_recommendations.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_watchlist_status.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/remove_all_watchlist.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/save_all_watchlist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AllMovieDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetAllMovieDetail getMovieDetail;
  final GetAllMovieRecommendations getMovieRecommendations;
  final GetAllWatchListTvShowStatus getWatchListStatus;
  final SaveAllWatchlistTvShow saveWatchlist;
  final RemoveAllWatchlistTvShow removeWatchlist;

  AllMovieDetailNotifier({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  late MovieDetail _movie;
  MovieDetail get movie => _movie;

  EnumStateRequest _movieState = EnumStateRequest.DataEmpty;
  EnumStateRequest get movieState => _movieState;

  List<Movie> _movieRecommendations = [];
  List<Movie> get movieRecommendations => _movieRecommendations;

  EnumStateRequest _recommendationState = EnumStateRequest.DataEmpty;
  EnumStateRequest get recommendationState => _recommendationState;

  String _msgge = '';
  String get msgge => _msgge;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchMovieDetail(int id) async {
    _movieState = EnumStateRequest.DataLoading;
    notifyListeners();
    final detailResult = await getMovieDetail.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _failure(failure);
      },
      (movie) {
        _movieS(movie);
        recommendationResult.fold(
          (failure) {
            _failureS(failure);
          },
          (movies) {
            _movieSs(movies);
          },
        );
        _movieState = EnumStateRequest.DataLoaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.mssg;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.idMovie);
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.mssg;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.idMovie);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final therslt = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = therslt;
    notifyListeners();
  }

  void _failure(failure){
    _movieState = EnumStateRequest.DataError;
    _msgge = failure.mssg;
    notifyListeners();
  }

  void _movieS(movie){
    _recommendationState = EnumStateRequest.DataLoading;
    _movie = movie;
    notifyListeners();
  }

  void _failureS(failure){
    _recommendationState = EnumStateRequest.DataError;
    _msgge = failure.mssg;
  }
  void _movieSs(movies){
    _recommendationState = EnumStateRequest.DataLoaded;
    _movieRecommendations = movies;
  }
}
