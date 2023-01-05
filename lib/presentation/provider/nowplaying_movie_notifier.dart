import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_now_playing_movies.dart';
import 'package:flutter/foundation.dart';

class NowPlayingAllMoviesNotifier extends ChangeNotifier {
  final GetAllNowPlayingMovies getAllNowPlayingMovies;

  NowPlayingAllMoviesNotifier({required this.getAllNowPlayingMovies});

  EnumStateRequest _enumStateRequest = EnumStateRequest.DataEmpty;
  EnumStateRequest get enumStateRequest => _enumStateRequest;

  List<Movie> _themovies = [];
  List<Movie> get themovies => _themovies;

  String _mssg = '';
  String get mssg => _mssg;

  Future<void> fetchNowPlayingAllMovies() async {
    _enumStateRequest = EnumStateRequest.DataLoading;
    notifyListeners();

    final theresult = await getAllNowPlayingMovies.execute();

    theresult.fold(
          (failureMovie) {
            _failure(failureMovie);
      },
          (themoviesData) {
            _data(themoviesData);
      },
    );
  }

  void _failure(failureMovie){
    _mssg = failureMovie.mssg;
    _enumStateRequest = EnumStateRequest.DataError;
    notifyListeners();
  }

  void _data(themoviesData){
    _themovies = themoviesData;
    _enumStateRequest = EnumStateRequest.DataLoaded;
    notifyListeners();
  }
}
