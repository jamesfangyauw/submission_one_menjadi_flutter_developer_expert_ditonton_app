import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/repositories/tv_show_repo.dart';

class SaveAllWatchlistTVShow {
  final TVShowRepo tvShowRepo;
  SaveAllWatchlistTVShow(this.tvShowRepo);

  Future<Either<FailureEquitable, String>> execute(TVShowDetail tv) {
    return tvShowRepo.saveWatchlistTvShow(tv);
  }
}
