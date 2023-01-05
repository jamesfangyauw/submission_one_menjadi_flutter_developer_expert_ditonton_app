import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/datasources/tv_local_ds.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/datasources/tv_remote_ds.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/table_tv.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/excepDb.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/repositories/tv_show_repo.dart';

class TVShowRepoImpl implements TVShowRepo {
  final TVRemoteDS tvRemoteDS;
  final TVLocalDS tvLocalDS;

  TVShowRepoImpl({
    required this.tvRemoteDS,
    required this.tvLocalDS,
  });

  Future<Either<FailureEquitable, List<TVEntities>>> getNowPlayingAllTVShow() async {
    try {
      final tvGetNowPlaying = tvRemoteDS.getNowPlayingTVShow();
      final thetheresult = await tvGetNowPlaying;
      return Right(thetheresult.map((model) => model.toEntity()).toList());
    } on ExceptServer {
      return Left(FailureServer(''));
    } on SocketException {
      return Left(FailureConnection(FAILED_NETWORK));
    }
  }

  Future<Either<FailureEquitable, TVShowDetail>> getTVShowDetail(int idtv) async {
    try {
      final tvGetDetail = tvRemoteDS.getTVShowDetail(idtv);
      final theresult = await tvGetDetail;
      return Right(theresult.toEntity());
    } on ExceptServer {
      return Left(FailureServer(''));
    } on SocketException {
      return Left(FailureConnection(FAILED_NETWORK));
    }
  }

  Future<Either<FailureEquitable, List<TVEntities>>> getAllTVShowRecommendations(int idtv) async {
    try {
      final tvGetRecomendations = tvRemoteDS.getTVShowRecommendations(idtv);
      final theresult = await tvGetRecomendations;
      return Right(theresult.map((model) => model.toEntity()).toList());
    } on ExceptServer {
      return Left(FailureServer(''));
    } on SocketException {
      return Left(FailureConnection(FAILED_NETWORK));
    }
  }

  Future<Either<FailureEquitable, List<TVEntities>>> getPopularAllTVShow() async {
    try {
      final tvGetPopular = tvRemoteDS.getPopularTVShow();
      final theresult = await tvGetPopular;
      return Right(theresult.map((model) => model.toEntity()).toList());
    } on ExceptServer {
      return Left(FailureServer(''));
    } on SocketException {
      return Left(FailureConnection(FAILED_NETWORK));
    }
  }

  Future<Either<FailureEquitable, List<TVEntities>>> getAllTopRatedTVShow() async {
    try {
      final tvGetTopRated = tvRemoteDS.getTopRatedTVShow();
      final theresult = await tvGetTopRated;
      return Right(theresult.map((model) => model.toEntity()).toList());
    } on ExceptServer {
      return Left(FailureServer(''));
    } on SocketException {
      return Left(FailureConnection(FAILED_NETWORK));
    }
  }

  Future<Either<FailureEquitable, List<TVEntities>>> searchTVSHow(String thequery) async {
    try {
      final tvSearch = tvRemoteDS.searchTVShow(thequery);
      final theresult = await tvSearch;
      return Right(theresult.map((model) => model.toEntity()).toList());
    } on ExceptServer {
      return Left(FailureServer(''));
    } on SocketException {
      return Left(FailureConnection(FAILED_NETWORK));
    }
  }

  Future<Either<FailureEquitable, String>> saveWatchlistTvShow(TVShowDetail tvDetail) async {
    print('TVDetail $tvDetail');
    try {
      final tvAddWatchlist = tvLocalDS.addWatchlistTVShow(TableTV.fromEntity(tvDetail));
      final theresult =
          await tvAddWatchlist;
      return Right(theresult);
    } on ExcepDB catch (e) {
      return Left(FailureDB(e.mssg));
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Either<FailureEquitable, String>> removeWatchlistTvShow(TVShowDetail tvDetail) async {
    try {
      final tvDeleteWatchlist = tvLocalDS.deleteWatchlistTVShow(TableTV.fromEntity(tvDetail));
      final theresult =
          await tvDeleteWatchlist ;
      return Right(theresult);
    } on ExcepDB catch (e) {
      return Left(FailureDB(e.mssg));
    }
  }

  Future<bool> isAddedToWatchlistTvShow(int idTv) async {
    final tvGetId = await tvLocalDS.getTVShowId(idTv);
    final theresult = tvGetId;
    return theresult != null;
  }

  Future<Either<FailureEquitable, List<TVEntities>>> getAllWatchlistTvShow() async {
    final tvGetWatchlist = await tvLocalDS.getWatchlistTVShow();
    final theresult = tvGetWatchlist;
    return Right(theresult.map((data) => data.toEntity()).toList());
  }
}
