import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_top_rated_tv_show.dart';

part './top_rated_tv_show_state.dart';

class TopRatedTVShowCubit extends Cubit<TopRatedTVShowState> {
  TopRatedTVShowCubit({
    required this.getTopRatedTVShow,
  }) : super(const TopRatedTVShowInitialState());

  final GetTopRatedTVShow getTopRatedTVShow;
  Future<void> fetchTopRatedTVShowCubit() async {
    emit(const TopRatedTVShowLoadingState());

    final theresult = await getTopRatedTVShow.execute();
    theresult.fold(
      (flr) => emit(TopRatedTVShowErrorState(flr.mssg)),
      (val) => emit(TopRatedTVShowLoadedState(tvShow: val)),
    );
  }
}
