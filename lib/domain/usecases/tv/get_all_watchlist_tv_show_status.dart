import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/repositories/tv_show_repo.dart';

class GetAllWatchListStatusTVShow {
  final TVShowRepo tvShowRepo;
  GetAllWatchListStatusTVShow(this.tvShowRepo);

  Future<bool> execute(int idTv) async {
    return tvShowRepo.isAddedToWatchlistTvShow(idTv);
  }
}
