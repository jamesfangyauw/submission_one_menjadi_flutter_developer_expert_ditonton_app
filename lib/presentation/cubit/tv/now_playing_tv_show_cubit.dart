import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_now_playing_tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'now_playing_tv_show_state.dart';
class NowPlayingTVShowCubit extends Cubit<NowPlayingTVShowState> {
  NowPlayingTVShowCubit({
    required this.getAllNowPlayingTVShow,
  }) : super(const NowPlayingTVShowInitialState());

  final GetAllNowPlayingTVShow getAllNowPlayingTVShow;
  Future<void> fetchNowPlayingTVShowCubit() async {
    emit(const NowPlayingTVShowLoadingState());

    final theresult = await getAllNowPlayingTVShow.execute();
    theresult.fold(
          (flr) => emit(NowPlayingTVShowErrorState(flr.mssg)),
          (val) => emit(NowPlayingTVShowLoadedState(tvShow: val)),
    );
  }
}
