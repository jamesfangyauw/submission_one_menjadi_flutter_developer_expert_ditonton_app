import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_movie.dart';
import 'package:equatable/equatable.dart';

class ResponseMovie extends Equatable {
  final List<ModelMovie> movieList;

  ResponseMovie({required this.movieList});

  factory ResponseMovie.fromJson(Map<String, dynamic> json) => ResponseMovie(
        movieList: List<ModelMovie>.from((json["results"] as List)
            .map((x) => ModelMovie.fromJson(x))
            .where((element) => element.posterPathMovie != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(movieList.map((x) => x.toJson())),
      };

  List<Object> get props => [movieList];
}
