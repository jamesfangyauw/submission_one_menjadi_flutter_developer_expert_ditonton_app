import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_popular_tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'popular_tv_show_state.dart';

class PopularTVShowCubit extends Cubit<PopularTVShowState> {
  PopularTVShowCubit({
    required this.getAllPopularTVShow,
  }) : super(const PopularTVShowInitialState());

  final GetAllPopularTVShow getAllPopularTVShow;
  Future<void> fetchPopularTVShowCubit() async {
    emit(const PopularTVShowLoadingState());
    final theresult = await getAllPopularTVShow.execute();

    theresult.fold(
      (flr) => emit(PopularTVShowErrorState(flr.mssg)),
      (val) => emit(PopularTVShowLoadedState(tvShow: val)),
    );
  }
}
