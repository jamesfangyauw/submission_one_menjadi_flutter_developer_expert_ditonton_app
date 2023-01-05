import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/excepDb.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/datasources/db/db_helper.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/table_tv.dart';

abstract class TVLocalDS {
  Future<String> addWatchlistTVShow(TableTV tvShow);
  Future<TableTV?> getTVShowId(int idTv);
  Future<String> deleteWatchlistTVShow(TableTV tvShow);
  Future<List<TableTV>> getWatchlistTVShow();
}

class TVLocalDataSourceImpl implements TVLocalDS {
  final DBHelper dbHelper;
  TVLocalDataSourceImpl({required this.dbHelper});
  Future<String> addWatchlistTVShow(TableTV tvShow) async {
    try {
      await dbHelper.addWatchlistTVShow(tvShow);
      return ADD_WATHCLIST;
    } catch (e) {
      throw ExcepDB(e.toString());
    }
  }

  Future<TableTV?> getTVShowId(int idTv) async {
    final theresult = await dbHelper.getTVShowId(idTv);
    if (theresult != null) {
      return TableTV.fromMap(theresult);
    } else {
      return null;
    }
  }


  Future<String> deleteWatchlistTVShow(TableTV tvShow) async {
    try {
      await dbHelper.deleteWatchlistTVShow(tvShow);
      return DELETE_WATCHLIST;
    } catch (e) {
      throw ExcepDB(e.toString());
    }
  }

  Future<List<TableTV>> getWatchlistTVShow() async {
    final theresult = await dbHelper.getWatchlistTVShow();
    return theresult.map((data) => TableTV.fromMap(data)).toList();
  }
}
