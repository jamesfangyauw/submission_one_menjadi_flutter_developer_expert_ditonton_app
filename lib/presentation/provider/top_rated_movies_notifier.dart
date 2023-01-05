import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_top_rated_movies.dart';
import 'package:flutter/foundation.dart';

class TopRatedMoviesNotifier extends ChangeNotifier {
  final GetAllTopRatedMovies getTopRatedMovies;

  TopRatedMoviesNotifier({required this.getTopRatedMovies});

  EnumStateRequest _state = EnumStateRequest.DataEmpty;
  EnumStateRequest get state => _state;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedMovies() async {
    _state = EnumStateRequest.DataLoading;
    notifyListeners();

    final therslt = await getTopRatedMovies.execute();

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
    _message = failure.mssg;
    _state = EnumStateRequest.DataError;
    notifyListeners();
  }

  void _data(moviesData){
    _movies = moviesData;
    _state = EnumStateRequest.DataLoaded;
    notifyListeners();
  }
}
