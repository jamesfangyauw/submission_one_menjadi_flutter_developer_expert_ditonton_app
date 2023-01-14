import 'package:flutter/cupertino.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:equatable/equatable.dart';

class ModelTVShow extends Equatable {
  @immutable  const ModelTVShow({
     this.pathBackdrop,
     this.date_first_show,
     this.genreIdTv=const[],
     this.idTv=0,
     this.name_origin,
     this.nameTv,
     this.language_origin,
     this.overview_tv='',
     this.tv_popularity=0,
     this.path_poster,
     this.average_vote=0,
     this.count_vote
  });

  final String? pathBackdrop;
  final String? date_first_show;
  final List<int> genreIdTv;
  final int idTv;
  final String? name_origin;
  final String? nameTv;
  final String? language_origin;
  final String overview_tv;
  final double tv_popularity;
  final String? path_poster;
  final double average_vote;
  final int? count_vote;

  factory ModelTVShow.fromJson(Map<String, dynamic> json) => ModelTVShow(
        pathBackdrop: json["backdropPath"],
        genreIdTv: List<int>.from(json["genre_ids"].map((x) => x)),
        idTv: json["id"],
        overview_tv: json["overview"],
        tv_popularity: json["popularity"].toDouble(),
        average_vote: json["vote_average"].toDouble(),
        count_vote: json["vote_count"],
        date_first_show:json["first_air_date"],
        nameTv: json["name"],
        language_origin: json["original_language"],
        name_origin: json["original_name"],
        path_poster: json["poster_path"]
      );

  Map<String, dynamic> toJson() => {
        "backdropPath": pathBackdrop,
        "genreIds": List<dynamic>.from(genreIdTv.map((x) => x)),
        "id": idTv,
        "overview": overview_tv,
        "popularity": tv_popularity,
        "vote_average": average_vote,
        "vote_count": count_vote,
        "first_air_date":date_first_show,
        "name":nameTv,
        "original_language":language_origin,
        "original_name":name_origin,
        "poster_path":path_poster,
      };

  TVEntities toEntity() {
    return TVEntities(
      pathBackdrop: this.pathBackdrop,
      genreIdsTv: this.genreIdTv,
      idTv: this.idTv,
      tv_overview: this.overview_tv,
      tv_popularity: this.tv_popularity,
      tv_voteAverage: this.average_vote,
      tv_voteCount: this.count_vote,
      path_poster: this.path_poster,
      name_original: this.name_origin,
      language_original: this.language_origin,
      nameTv: this.nameTv,
      date_first_show: this.date_first_show
    );
  }

  @override
  List<Object?> get props => [
        pathBackdrop,
        genreIdTv,
        idTv,
        overview_tv,
        tv_popularity,
        average_vote,
        count_vote,
        date_first_show,
        nameTv,
        language_origin,
        path_poster,
        name_origin
      ];
}
