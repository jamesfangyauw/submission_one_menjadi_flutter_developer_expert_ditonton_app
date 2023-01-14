import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_tv_show_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_watchlist_tv_show_status.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/remove_all_watchlist_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/save_all_watchlist_tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_tv_show_state.dart';

class DetailTVShowCubit extends Cubit<DetailTVShowState> {
  DetailTVShowCubit({
    required this.getAllTVShowDetail,
    required this.saveAllTVShowWatchlist,
    required this.removeAllTVShowWatchlist,
    required this.getAllWatchListTVShowStatus,
  }) : super(const DetailTVShowState());

  final GetAllTVShowDetail getAllTVShowDetail;
  final SaveAllWatchlistTVShow saveAllTVShowWatchlist;
  final RemoveAllWatchlistTVShow removeAllTVShowWatchlist;
  final GetAllWatchListStatusTVShow getAllWatchListTVShowStatus;

  static const mssgAddWatchlist = 'Added to Watchlist';
  static const mssgRemoveWatchlist = 'Removed from Watchlist';

  Future<void> fetchDetailTVShowCubit(int idTVShow) async {
    emit(state.setEnumStateRequest(EnumStateRequest.DataLoading));
    final theresult = await getAllTVShowDetail.execute(idTVShow);
    theresult.fold(
      (flr) {
        emit(
          DetailTVShowState(
            mssg: flr.mssg,
            enumStateRequest: EnumStateRequest.DataError,
          ),
        );
      },
      (tvShow) {
        emit(
          DetailTVShowState(
            enumStateRequest: EnumStateRequest.DataLoaded,
            tvShowDetail: tvShow,
          ),
        );
      },
    );
  }

  Future<void> addWatchlistTVShow(TVShowDetail tvShowDetail) async {
    final theresult = await saveAllTVShowWatchlist.execute(tvShowDetail);
    theresult.fold(
        (flr) async {
        emit(
          state.copyWith(
            mssgWatchlist: flr.mssg,
          ),
        );
      },
          (successMssg) async {
        emit(
          state.copyWith(
            mssgWatchlist: successMssg,
          ),
        );
      },
    );
    await getWatchlistStatusTVShow(tvShowDetail.tvShowId);
  }

  Future<void> removeWatchlistTVShow(TVShowDetail tvShowDetail) async {
    final theresult = await removeAllTVShowWatchlist.execute(tvShowDetail);
    theresult.fold(
        (flr) async {
        emit(
          state.copyWith(
            mssgWatchlist: flr.mssg,
          ),
        );
      },
          (successMssg) async {
        emit(
          state.copyWith(
            mssgWatchlist: successMssg,
          ),
        );
      },
    );
    await getWatchlistStatusTVShow(tvShowDetail.tvShowId);
  }

  Future<void> getWatchlistStatusTVShow(int idTVShow) async {
    final theresult = await getAllWatchListTVShowStatus.execute(idTVShow);
    emit(state.setAddTVShowToWatchlist(theresult));
  }
}
