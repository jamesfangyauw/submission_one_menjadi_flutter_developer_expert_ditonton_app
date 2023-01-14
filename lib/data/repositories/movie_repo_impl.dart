import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/datasources/movie_local_ds.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/datasources/movie_remote_ds.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/table_movie.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/repositories/movie_repo.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/excepDb.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/failure_equatable.dart';

class MovieRepoImpl implements MovieRepository {
  final MovieRemoteDS movieRemoteDS;
  final MovieLocalDS movieLocalDS;

  MovieRepoImpl({
    required this.movieRemoteDS,
    required this.movieLocalDS,
  });

  Future<Either<FailureEquitable, List<Movie>>> getNowPlayingMovies() async {
    try {
      final theresult = await movieRemoteDS.getNowPlayingAllMovies();
      return Right(theresult.map((model) => model.toEntity()).toList());
    } on ExceptServer {
      return Left(FailureServer(''));
    } on SocketException {
      return Left(FailureConnection(FAILED_NETWORK));
    } on TlsException catch (e) {
      return Left(FailureCommon('Certificated is not valid\n${e.message}'));
    } catch (e) {
      return Left(FailureCommon(e.toString()));
    }
  }

  Future<Either<FailureEquitable, MovieDetail>> getMovieDetail(int idMovie) async {
    try {
      final theresult = await movieRemoteDS.getMoviesDetail(idMovie);
      return Right(theresult.toEntity());
    } on ExceptServer {
      return Left(FailureServer(''));
    } on SocketException {
      return Left(FailureConnection(FAILED_NETWORK));
    } on TlsException catch (e) {
      return Left(FailureCommon('Certificated is not valid\n${e.message}'));
    } catch (e) {
      return Left(FailureCommon(e.toString()));
    }
  }

  Future<Either<FailureEquitable, List<Movie>>> getMovieRecommendations(int idMovie) async {
    try {
      final theresult = await movieRemoteDS.getAllMovieRecommendations(idMovie);
      return Right(theresult.map((model) => model.toEntity()).toList());
    } on ExceptServer {
      return Left(FailureServer(''));
    } on SocketException {
      return Left(FailureConnection(FAILED_NETWORK));
    } on TlsException catch (e) {
      return Left(FailureCommon('Certificated is not valid\n${e.message}'));
    } catch (e) {
      return Left(FailureCommon(e.toString()));
    }
  }

  Future<Either<FailureEquitable, List<Movie>>> getPopularMovies() async {
    try {
      final theresult = await movieRemoteDS.getPopularAllMovies();
      return Right(theresult.map((model) => model.toEntity()).toList());
    } on ExceptServer {
      return Left(FailureServer(''));
    } on SocketException {
      return Left(FailureConnection(FAILED_NETWORK));
    } on TlsException catch (e) {
      return Left(FailureCommon('Certificated is not valid\n${e.message}'));
    } catch (e) {
      return Left(FailureCommon(e.toString()));
    }
  }

  Future<Either<FailureEquitable, List<Movie>>> getTopRatedMovies() async {
    try {
      final theresult = await movieRemoteDS.getTopRatedAllMovies();
      return Right(theresult.map((model) => model.toEntity()).toList());
    } on ExceptServer {
      return Left(FailureServer(''));
    } on SocketException {
      return Left(FailureConnection(FAILED_NETWORK));
    } on TlsException catch (e) {
      return Left(FailureCommon('Certificated is not valid\n${e.message}'));
    } catch (e) {
      return Left(FailureCommon(e.toString()));
    }
  }

  Future<Either<FailureEquitable, List<Movie>>> searchMovies(String thequery) async {
    try {
      final theresult = await movieRemoteDS.searchTheMovies(thequery);
      return Right(theresult.map((model) => model.toEntity()).toList());
    } on ExceptServer {
      return Left(FailureServer(''));
    } on SocketException {
      return Left(FailureConnection(FAILED_NETWORK));
    } on TlsException catch (e) {
      return Left(FailureCommon('Certificated is not valid\n${e.message}'));
    } catch (e) {
      return Left(FailureCommon(e.toString()));
    }
  }

  Future<Either<FailureEquitable, String>> saveWatchlist(MovieDetail themovie) async {
    try {
      final theresult =
          await movieLocalDS.addWatchlist(TableMovie.fromEntity(themovie));
      return Right(theresult);
    } on ExcepDB catch (e) {
      return Left(FailureDB(e.mssg));
    } catch (e) {
      throw e;
    } 
  }

  Future<Either<FailureEquitable, String>> removeWatchlist(MovieDetail themovie) async {
    try {
      final theresult =
          await movieLocalDS.deleteWatchlist(TableMovie.fromEntity(themovie));
      return Right(theresult);
    } on ExcepDB catch (e) {
      return Left(FailureDB(e.mssg));
    } 
  }

  Future<bool> isAddedToWatchlist(int idMovie) async {
    final theresult = await movieLocalDS.getMovieId(idMovie);
    return theresult != null;
  }

  Future<Either<FailureEquitable, List<Movie>>> getWatchlistMovies() async {
    final theresult = await movieLocalDS.getWatchlistAllMovie();
    return Right(theresult.map((data) => data.toEntity()).toList());
  }
}
