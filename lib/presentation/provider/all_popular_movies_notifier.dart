import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_popular_movies.dart';
import 'package:flutter/foundation.dart';

class AllPopularMoviesNotifier extends ChangeNotifier {
  final GetAllPopularMovies getPopularMovies;

  AllPopularMoviesNotifier(this.getPopularMovies);

  EnumStateRequest _enumStateRequest = EnumStateRequest.DataEmpty;
  EnumStateRequest get enumStateRequest => _enumStateRequest;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularMovies() async {
    _enumStateRequest = EnumStateRequest.DataLoading;
    notifyListeners();

    final therslt = await getPopularMovies.execute();

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
    _enumStateRequest = EnumStateRequest.DataError;
    notifyListeners();
  }

  void _data(moviesData){
    _movies = moviesData;
    _enumStateRequest = EnumStateRequest.DataLoaded;
    notifyListeners();
  }
}
