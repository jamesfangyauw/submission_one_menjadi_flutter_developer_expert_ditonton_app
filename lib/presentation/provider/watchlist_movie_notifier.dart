import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_watchlist_movies.dart';
import 'package:flutter/foundation.dart';

class WatchlistMovieNotifier extends ChangeNotifier {
  var _watchlistMovies = <Movie>[];
  List<Movie> get watchlistMovies => _watchlistMovies;

  var _watchlistState = EnumStateRequest.DataEmpty;
  EnumStateRequest get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistMovieNotifier({required this.getWatchlistMovies});

  final GetAllWatchlistMovies getWatchlistMovies;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = EnumStateRequest.DataLoading;
    notifyListeners();

    final therslt = await getWatchlistMovies.execute();
    therslt.fold(
      (failure) {
        _failure(failure);
      },
      (moviesData) {
        _data(moviesData);
      },
    );
  }

  void _failure(failure){
    _watchlistState = EnumStateRequest.DataError;
    _message = failure.mssg;
    notifyListeners();
  }

  void _data(moviesData){
    _watchlistState = EnumStateRequest.DataLoaded;
    _watchlistMovies = moviesData;
    notifyListeners();
  }
}
