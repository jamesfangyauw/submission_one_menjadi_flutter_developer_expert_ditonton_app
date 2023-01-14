import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/repositories/movie_repo.dart';

class RemoveAllWatchlistTheMovies {
  final MovieRepository movieRepository;
  RemoveAllWatchlistTheMovies(this.movieRepository);

  Future<Either<FailureEquitable, String>> execute(MovieDetail movie) {
    return movieRepository.removeWatchlist(movie);
  }
}
