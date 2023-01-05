import 'package:flutter/cupertino.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class ModelSeasonTvMovie extends Equatable {
  @immutable ModelSeasonTvMovie(
      {required this.datAirRelease,
        required this.epsCount,
        required this.idTvMovie,
        required this.nameTvMovie,
        required this.overviewTvMovie,
        required this.posterPathTvMovie,
        required this.seasonNumberTvMovie});
  final String? datAirRelease;
  final int epsCount;
  final int idTvMovie;
  final String nameTvMovie;
  final String overviewTvMovie;
  final String? posterPathTvMovie;
  final int seasonNumberTvMovie;
  factory ModelSeasonTvMovie.fromJson(Map<String, dynamic> json) => ModelSeasonTvMovie(
    datAirRelease: json["air_date"],
    epsCount: json["episode_count"],
    idTvMovie: json["id"],
    nameTvMovie: json["name"],
    overviewTvMovie: json["overview"],
    posterPathTvMovie: json["poster_path"],
    seasonNumberTvMovie: json["season_number"],
  );

  Map<String, dynamic> toJson() => {
    "air_date": datAirRelease,
    "episode_count": epsCount,
    "id": idTvMovie,
    "name": nameTvMovie,
    "overview": overviewTvMovie,
    "poster_path": posterPathTvMovie,
    "season_number": seasonNumberTvMovie,
  };

  SeasonEntities toEntity() => SeasonEntities(
    idSeason: this.idTvMovie,
    posterPathSeason: this.posterPathTvMovie,
    seasonNum: this.seasonNumberTvMovie,
    epsCount: this.epsCount,
  );

  @override
  List<Object?> get props => [
    this.datAirRelease,
    this.epsCount,
    this.idTvMovie,
    this.nameTvMovie,
    this.overviewTvMovie,
    this.posterPathTvMovie,
    this.seasonNumberTvMovie
  ];
}