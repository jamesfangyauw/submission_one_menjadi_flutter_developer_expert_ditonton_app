import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/genre_entities.dart';
import 'package:equatable/equatable.dart';

class TVShowDetail extends Equatable {
  const TVShowDetail({
     this.tvBckdropPath,
     this.tv_first_release='',
     this.tvGenres=const[],
     this.tvShowId=0,
     this.tv_show_originame='',
     this.tv_show_name='',
     this.origlanguage_tv_show='',
     this.tvShowOverview='',
     this.tvShowPopularityPublic=0,
     this.tv_show_pstrpath='',
     this.tv_show_voteAvg=0,
     this.tv_show_voteCnt
  });
  final String? tvBckdropPath;
  final String tv_first_release;
  final List<GenreEntities> tvGenres;
  final int tvShowId;
  final String tv_show_originame;
  final String tv_show_name;
  final String origlanguage_tv_show;
  final String tvShowOverview;
  final double tvShowPopularityPublic;
  final String tv_show_pstrpath;
  final double tv_show_voteAvg;
  final int? tv_show_voteCnt;
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
