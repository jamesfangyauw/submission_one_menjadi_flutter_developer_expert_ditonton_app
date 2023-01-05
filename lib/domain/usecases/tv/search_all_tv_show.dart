import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/repositories/tv_show_repo.dart';

class SearchAllTVShow {
  final TVShowRepo tvShowRepo;
  SearchAllTVShow(this.tvShowRepo);

  Future<Either<FailureEquitable, List<TVEntities>>> execute(String query) {
    return tvShowRepo.searchTVSHow(query);
  }
}
