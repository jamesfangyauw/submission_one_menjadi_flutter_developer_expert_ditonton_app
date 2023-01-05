import 'package:equatable/equatable.dart';

class SeasonEntities extends Equatable {
  SeasonEntities({
    required this.idSeason,
    required this.posterPathSeason,
    required this.seasonNum,
    required this.epsCount,
  });
  final int idSeason;
  final String? posterPathSeason;
  final int seasonNum;
  final int epsCount;

  List<Object?> get props => [idSeason, posterPathSeason, seasonNum, epsCount];
}