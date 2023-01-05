import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/genre_entities.dart';
import 'package:equatable/equatable.dart';

class TVShowDetail extends Equatable {
  TVShowDetail({
    required this.tvBckdropPath,
    required this.tv_first_release,
    required this.tvGenres,
    required this.tvShowId,
    required this.tv_show_originame,
    required this.tv_show_name,
    required this.origlanguage_tv_show,
    required this.tvShowOverview,
    required this.tvShowPopularityPublic,
    required this.tv_show_pstrpath,
    required this.tv_show_voteAvg,
    required this.tv_show_voteCnt
  });
  String? tvBckdropPath;
  String tv_first_release;
  List<GenreEntities> tvGenres;
  int tvShowId;
  String tv_show_originame;
  String tv_show_name;
  String origlanguage_tv_show;
  String tvShowOverview;
  double tvShowPopularityPublic;
  String tv_show_pstrpath;
  double tv_show_voteAvg;
  int? tv_show_voteCnt;
  List<Object?> get props => [
        tvBckdropPath,
        tv_first_release,
        tvGenres,
        tvShowId,
        tv_show_originame,
        tv_show_name,
        origlanguage_tv_show,
        tvShowOverview,
        tvShowPopularityPublic,
        tv_show_pstrpath,
        tv_show_voteAvg,
        tv_show_voteCnt
      ];
}
