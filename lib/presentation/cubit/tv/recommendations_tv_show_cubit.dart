import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/get_all_tv_show_recommendations.dart';

part './recommendations_tv_show_state.dart';

class RecommendationsTVShowCubit extends Cubit<RecommendationsTVShowState> {
  RecommendationsTVShowCubit({
    required this.getAllTVShowRecommendations,
  }) : super(const RecommendationsTVShowInitialState());
  final GetAllTVShowRecommendations getAllTVShowRecommendations;

  Future<void> fetchRecommendationsTVShowCubit(int idTvShow) async {
    emit(const RecommendationsTVShowLoadingState());
    final theresult = await getAllTVShowRecommendations.execute(idTvShow);
    theresult.fold(
      (flr) => emit(RecommendationsTVShowErrorState(flr.mssg)),
      (val) => emit(RecommendationsTVShowLoadedState(items: val)),
    );
  }
}
