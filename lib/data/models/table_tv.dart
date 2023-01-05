import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TableTV extends Equatable {
  final int idTv;
  final String? nametv;
  final String? posterPathTv;
  final String? overviewTv;

  TableTV({
    required this.idTv,
    required this.nametv,
    required this.posterPathTv,
    required this.overviewTv,
  });
  factory TableTV.fromEntity(TVShowDetail tv) => TableTV(
        idTv: tv.tvShowId,
        nametv: tv.tv_show_name,
        posterPathTv: tv.tv_show_pstrpath,
        overviewTv: tv.tvShowOverview,
      );

  factory TableTV.fromMap(Map<String, dynamic> map) => TableTV(
        idTv: map['id'],
        nametv: map['name'],
        posterPathTv: map['posterPath'],
        overviewTv: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': idTv,
        'name': nametv,
        'posterPath': posterPathTv,
        'overview': overviewTv,
      };

  TVEntities toEntity() => TVEntities.watchlist(
        idTv: idTv,
        tv_overview: overviewTv,
        path_poster: posterPathTv,
        nameTv: nametv,
      );
  List<Object?> get props => [idTv, nametv, posterPathTv, overviewTv];
}
