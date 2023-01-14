import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/repositories/movie_repo.dart';
@lazySingleton
class SearchAllMovies {
  final MovieRepository movierepository;
  SearchAllMovies(this.movierepository);
  Future<Either<FailureEquitable, List<Movie>>> execute(String query) {
    return movierepository.searchMovies(query);
  }
}
