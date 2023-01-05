import 'dart:convert';

import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_movie_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_movie.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/response_movie.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/excepDb.dart';
import 'package:http/http.dart' as http;

import '../../common/URL_BASE.dart';

abstract class MovieRemoteDS {
  Future<List<ModelMovie>> getNowPlayingAllMovies();
  Future<List<ModelMovie>> getPopularAllMovies();
  Future<List<ModelMovie>> getTopRatedAllMovies();
  Future<ModelMovieDetailResponse> getMoviesDetail(int idMovies);
  Future<List<ModelMovie>> getAllMovieRecommendations(int idMovies);
  Future<List<ModelMovie>> searchTheMovies(String queryMovies);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDS {
  final http.Client clientHTTP;

  MovieRemoteDataSourceImpl({required this.clientHTTP});

  Future<List<ModelMovie>> getNowPlayingAllMovies() async {
    final theresponse =
        await clientHTTP.get(Uri.parse('$URL_BASE/movie/now_playing?$KEY_API'));
    return checkResponse(theresponse);
  }

  Future<ModelMovieDetailResponse> getMoviesDetail(int idMovie) async {
    final theresponse =
        await clientHTTP.get(Uri.parse('$URL_BASE/movie/$idMovie?$KEY_API'));
    return showDetailRespon(theresponse);
  }

  Future<List<ModelMovie>> getAllMovieRecommendations(int idMovie) async {
    final theresponse = await clientHTTP
        .get(Uri.parse('$URL_BASE/movie/$idMovie/recommendations?$KEY_API'));
    return checkResponse(theresponse);
  }

  Future<List<ModelMovie>> getPopularAllMovies() async {
    final theresponse =
        await clientHTTP.get(Uri.parse('$URL_BASE/movie/popular?$KEY_API'));
        return checkResponse(theresponse);
  }

  Future<List<ModelMovie>> getTopRatedAllMovies() async {
    final theresponse =
        await clientHTTP.get(Uri.parse('$URL_BASE/movie/top_rated?$KEY_API'));
    return checkResponse(theresponse);
  }

  Future<List<ModelMovie>> searchTheMovies(String querydb) async {
    final theresponse = await clientHTTP
        .get(Uri.parse('$URL_BASE/search/movie?$KEY_API&query=$querydb'));
    return checkResponse(theresponse);
  }

  List<ModelMovie> checkResponse(theresponse){
    if (theresponse.statusCode == 200) {
      return ResponseMovie.fromJson(json.decode(theresponse.body)).movieList;
    } else {
      throw ExceptServer();
    }
  }
  ModelMovieDetailResponse showDetailRespon(theresponse){
    if (theresponse.statusCode == 200) {
      return ModelMovieDetailResponse.fromJson(json.decode(theresponse.body));
    } else {
      throw ExceptServer();
    }
  }
}
