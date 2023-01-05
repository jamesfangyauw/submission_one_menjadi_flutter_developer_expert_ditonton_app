import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/search_all_movies.dart';
import 'package:flutter/foundation.dart';

class All_MovieSearchNotifier extends ChangeNotifier {
  final SearchAllMovies searchMovies;
  All_MovieSearchNotifier({required this.searchMovies});

  EnumStateRequest _state = EnumStateRequest.DataEmpty;
  EnumStateRequest get state => _state;

  List<Movie> _searchResult = [];
  List<Movie> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieSearch(String query) async {
    _state = EnumStateRequest.DataLoading;
    notifyListeners();

    final therslt = await searchMovies.execute(query);
    therslt.fold(
      (failure) {
        _failure(failure);
      },
      (data) {
        _data(data);
      },
    );
  }

  void _failure(failure){
    _message = failure.mssg;
    _state = EnumStateRequest.DataError;
    notifyListeners();
  }

  void _data(data){
    _searchResult = data;
    _state = EnumStateRequest.DataLoaded;
    notifyListeners();
  }
}
