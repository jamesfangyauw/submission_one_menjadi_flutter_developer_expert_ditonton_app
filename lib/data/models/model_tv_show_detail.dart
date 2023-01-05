import 'package:flutter/cupertino.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

import 'model_genre.dart';

class ModelTVShowDetailResponse extends Equatable {
  @immutable ModelTVShowDetailResponse({
    required this.pathBackdrop,
    required this.date_first_show,
    required this.genreTv,
    required this.idTv,
    required this.name_original,
    required this.nameTv,
    required this.language_original,
    required this.overviewTv,
    required this.tvPopularity,
    required this.path_poster,
    required this.tvVoteAverage,
    required this.tvVoteCount
  });

  final String? pathBackdrop;
  final String date_first_show;
  final List<ModelGenre> genreTv;
  final int idTv;
  final String name_original;
  final String nameTv;
  final String language_original;
  final String overviewTv;
  final double tvPopularity;
  final String path_poster;
  final double tvVoteAverage;
  final int? tvVoteCount;


  factory ModelTVShowDetailResponse.fromJson(Map<String, dynamic> json) =>
      ModelTVShowDetailResponse(
          pathBackdrop: json["backdrop_path"],
          genreTv: List<ModelGenre>.from(
              json["genres"].map((x) => ModelGenre.fromJson(x))),
          idTv: json["id"],
          overviewTv: json["overview"],
          tvPopularity: json["popularity"].toDouble(),
          tvVoteAverage: json["vote_average"].toDouble(),
          tvVoteCount: json["vote_count"],
          date_first_show:json["first_air_date"],
          nameTv: json["name"],
          language_original: json["original_language"],
          name_original: json["original_name"],
          path_poster: json["poster_path"]
      );

  Map<String, dynamic> toJson() => {
    "backdrop_path": pathBackdrop,
    "genres": List<dynamic>.from(genreTv.map((x) => x)),
    "id": idTv,
    "overview": overviewTv,
    "popularity": tvPopularity,
    "vote_average": tvVoteAverage,
    "vote_count": tvVoteCount,
    "first_air_date":date_first_show,
    "name":nameTv,
    "original_language":language_original,
    "original_name":name_original,
    "poster_path":path_poster,
  };

  TVShowDetail toEntity() {
    return TVShowDetail(
        tvBckdropPath: this.pathBackdrop,
        tvGenres: this.genreTv.map((genre) => genre.toEntity()).toList(),
        tvShowId: this.idTv,
        tvShowOverview: this.overviewTv,
        tvShowPopularityPublic: this.tvPopularity,
        tv_show_voteAvg: this.tvVoteAverage,
        tv_show_voteCnt: this.tvVoteCount,
        tv_show_pstrpath: this.path_poster,
        tv_show_originame: this.name_original,
        origlanguage_tv_show: this.language_original,
        tv_show_name: this.nameTv,
        tv_first_release: this.date_first_show
    );
  }

  List<Object?> get props => [
        pathBackdrop,
        genreTv,
        idTv,
        overviewTv,
        tvPopularity,
        tvVoteAverage,
        tvVoteCount,
        date_first_show,
        nameTv,
        language_original,
        path_poster,
        name_original
      ];
}
