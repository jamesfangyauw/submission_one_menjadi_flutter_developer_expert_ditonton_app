import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/excepDb.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/datasources/db/db_helper.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/table_movie.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
abstract class MovieLocalDS {
  Future<String> addWatchlist(TableMovie themovie);
  Future<String> deleteWatchlist(TableMovie themovie);
  Future<TableMovie?> getMovieId(int idMovie);
  Future<List<TableMovie>> getWatchlistAllMovie();
}

class MovieLocalDSImpl implements MovieLocalDS {
  final DBHelper dbHelper;
  MovieLocalDSImpl({required this.dbHelper});

  Future<String> addWatchlist(TableMovie themovie) async {
    try {
      await dbHelper.addWatchlistMovie(themovie);
      return ADD_WATHCLIST;
    } catch (e) {
      throw ExcepDB(e.toString());
    }
  }

  Future<String> deleteWatchlist(TableMovie themovie) async {
    try {
      await dbHelper.deleteWatchlistMovie(themovie);
      return DELETE_WATCHLIST;
    } catch (e) {
      throw ExcepDB(e.toString());
    }
  }


  Future<TableMovie?> getMovieId(int idMovie) async {
    final theresult = await dbHelper.getMoviesId(idMovie);
    if (theresult != null) {
      return TableMovie.fromMap(theresult);
    } else {
      return null;
    }
  }


  Future<List<TableMovie>> getWatchlistAllMovie() async {
    final theresult = await dbHelper.getWatchlistTheMovie();
    return theresult.map((data) => TableMovie.fromMap(data)).toList();
  }
}
