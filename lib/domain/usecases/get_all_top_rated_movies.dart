import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/repositories/movie_repo.dart';

class GetAllTopRatedMovies {
  final MovieRepository movieRepository;
  GetAllTopRatedMovies(this.movieRepository);
  Future<Either<FailureEquitable, List<Movie>>> execute() {
    return movieRepository.getTopRatedMovies();
  }
}
