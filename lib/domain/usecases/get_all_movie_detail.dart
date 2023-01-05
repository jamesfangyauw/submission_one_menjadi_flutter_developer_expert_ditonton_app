import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/repositories/movie_repo.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';

class GetAllMovieDetail {
  final MovieRepository movierepository;
  GetAllMovieDetail(this.movierepository);
  Future<Either<FailureEquitable, MovieDetail>> execute(int id) {
    return movierepository.getMovieDetail(id);
  }
}
