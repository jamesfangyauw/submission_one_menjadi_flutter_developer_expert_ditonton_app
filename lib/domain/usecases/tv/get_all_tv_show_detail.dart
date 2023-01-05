import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/repositories/tv_show_repo.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';

class GetAllTVShowDetail {
  final TVShowRepo tvShowRepo;
  GetAllTVShowDetail(this.tvShowRepo);

  Future<Either<FailureEquitable, TVShowDetail>> execute(int idtv) {
    return tvShowRepo.getTVShowDetail(idtv);
  }
}
