import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';

abstract class TVShowRepo {
  Future<Either<FailureEquitable, List<TVEntities>>> getNowPlayingAllTVShow();
  Future<Either<FailureEquitable, List<TVEntities>>> getPopularAllTVShow();
  Future<Either<FailureEquitable, TVShowDetail>> getTVShowDetail(int idTv);
  Future<Either<FailureEquitable, List<TVEntities>>> getAllTVShowRecommendations(int idTv);
  Future<Either<FailureEquitable, List<TVEntities>>> getAllTopRatedTVShow();
  Future<Either<FailureEquitable, List<TVEntities>>> searchTVSHow(String thequery);
  Future<Either<FailureEquitable, String>> saveWatchlistTvShow(TVShowDetail tvDetail);
  Future<Either<FailureEquitable, String>> removeWatchlistTvShow(TVShowDetail tvDetail);
  Future<bool> isAddedToWatchlistTvShow(int idTv);
  Future<Either<FailureEquitable, List<TVEntities>>> getAllWatchlistTvShow();
}
