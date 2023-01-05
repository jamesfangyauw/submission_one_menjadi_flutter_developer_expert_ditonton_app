import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_now_playing_movies.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_popular_movies.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_top_rated_movies.dart';
import 'package:flutter/material.dart';

class AllMovieListNotifier extends ChangeNotifier {
  var _nowPlayingMovies = <Movie>[];
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  EnumStateRequest _nowPlayingState = EnumStateRequest.DataEmpty;
  EnumStateRequest get nowPlayingState => _nowPlayingState;

  var _popularMovies = <Movie>[];
  List<Movie> get popularMovies => _popularMovies;

  EnumStateRequest _popularMoviesState = EnumStateRequest.DataEmpty;
  EnumStateRequest get popularMoviesState => _popularMoviesState;

  var _topRatedMovies = <Movie>[];
  List<Movie> get topRatedMovies => _topRatedMovies;

  EnumStateRequest _topRatedMoviesState = EnumStateRequest.DataEmpty;
  EnumStateRequest get topRatedMoviesState => _topRatedMoviesState;

  String _message = '';
  String get message => _message;

  AllMovieListNotifier({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  });

  final GetAllNowPlayingMovies getNowPlayingMovies;
  final GetAllPopularMovies getPopularMovies;
  final GetAllTopRatedMovies getTopRatedMovies;

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingState = EnumStateRequest.DataLoading;
    notifyListeners();

    final theresult = await getNowPlayingMovies.execute();
    theresult.fold(
      (failure) {
        _failureNowPlaying(failure);
      },
      (moviesData) {
        _moviesDataNowPlaying(moviesData);
      },
    );
  }

  Future<void> fetchPopularMovies() async {
    _popularMoviesState = EnumStateRequest.DataLoading;
    notifyListeners();

    final theresult = await getPopularMovies.execute();
    theresult.fold(
      (failure) {
        _failurePopular(failure);
      },
      (moviesData) {
        _moviesDataPopular(moviesData);
      },
    );
  }

  Future<void> fetchTopRatedMovies() async {
    _topRatedMoviesState = EnumStateRequest.DataLoading;
    notifyListeners();

    final theresult = await getTopRatedMovies.execute();
    theresult.fold(
      (failure) {
        _failureTopRated(failure);
      },
      (moviesData) {
        _moviesDataTopRated(moviesData);
      },
    );
  }

  void _failureNowPlaying(failure){
    _nowPlayingState = EnumStateRequest.DataError;
    _message = failure.mssg;
    notifyListeners();
  }

  void _moviesDataNowPlaying(moviesData){
    _nowPlayingState = EnumStateRequest.DataLoaded;
    _nowPlayingMovies = moviesData;
    notifyListeners();
  }

  void _failurePopular(failure){
    _popularMoviesState = EnumStateRequest.DataError;
    _message = failure.mssg;
    notifyListeners();
  }

  void _moviesDataPopular(moviesData){
    _popularMoviesState = EnumStateRequest.DataLoaded;
    _popularMovies = moviesData;
    notifyListeners();
  }

  void _failureTopRated(failure){
    _topRatedMoviesState = EnumStateRequest.DataError;
    _message = failure.mssg;
    notifyListeners();
  }

  void _moviesDataTopRated(moviesData){
    _topRatedMoviesState = EnumStateRequest.DataLoaded;
    _topRatedMovies = moviesData;
    notifyListeners();
  }
}
