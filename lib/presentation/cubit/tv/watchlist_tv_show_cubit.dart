import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_watchlist_tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_tv_show_state.dart';

class WatchlistTVShowCubit extends Cubit<WatchlistTVShowState> {
  WatchlistTVShowCubit({
    required this.getAllWatchlistTVShow,
  }) : super(const WatchlistTVShowInitialState());

  final GetAllWatchlistTVShow getAllWatchlistTVShow;

  Future<void> fetchWatchlistTVShowCubit() async {
    emit(const WatchlistLoadingTVShowState());
    final theresult = await getAllWatchlistTVShow.execute();
    theresult.fold(
      (flr) => emit(WatchlistTVShowErrorState(flr.mssg)),
      (val) => emit(WatchlistTVShowLoadedState(tvShow: val)),
    );
  }
}
