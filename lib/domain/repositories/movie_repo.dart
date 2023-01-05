import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';

abstract class MovieRepository {
  Future<Either<FailureEquitable, List<Movie>>> getNowPlayingMovies();
  Future<Either<FailureEquitable, List<Movie>>> getPopularMovies();
  Future<Either<FailureEquitable, List<Movie>>> getTopRatedMovies();
  Future<Either<FailureEquitable, MovieDetail>> getMovieDetail(int id);
  Future<Either<FailureEquitable, List<Movie>>> getMovieRecommendations(int id);
  Future<Either<FailureEquitable, List<Movie>>> searchMovies(String query);
  Future<Either<FailureEquitable, String>> saveWatchlist(MovieDetail movie);
  Future<Either<FailureEquitable, String>> removeWatchlist(MovieDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<FailureEquitable, List<Movie>>> getWatchlistMovies();
}
