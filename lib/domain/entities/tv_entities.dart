import 'package:equatable/equatable.dart';

class TVEntities extends Equatable {
  TVEntities({
    required this.pathBackdrop,
    required this.date_first_show,
    required this.genreIdsTv,
    required this.idTv,
    required this.name_original,
    required this.nameTv,
    required this.language_original,
    required this.tv_overview,
    required this.tv_popularity,
    required this.path_poster,
    required this.tv_voteAverage,
    required this.tv_voteCount
  });
  TVEntities.watchlist({
    required this.idTv,
    required this.tv_overview,
    required this.path_poster,
    required this.nameTv
  });
  String? pathBackdrop;
  String? date_first_show;
  List<int>? genreIdsTv;
  int idTv;
  String? name_original;
  String? nameTv;
  String? language_original;
  String? tv_overview;
  double? tv_popularity;
  String? path_poster;
  double? tv_voteAverage;
  int? tv_voteCount;
  List<Object?> get props => [
        pathBackdrop,
        date_first_show,
        genreIdsTv,
        idTv,
        name_original,
        nameTv,
        language_original,
        tv_overview,
        tv_popularity,
        path_poster,
        tv_voteAverage,
        tv_voteCount
      ];
}
