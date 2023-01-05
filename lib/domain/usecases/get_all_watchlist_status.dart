import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/repositories/movie_repo.dart';

class GetAllWatchListTvShowStatus {
  final MovieRepository movieRepository;
  GetAllWatchListTvShowStatus(this.movieRepository);

  Future<bool> execute(int id) async {
    return movieRepository.isAddedToWatchlist(id);
  }
}
