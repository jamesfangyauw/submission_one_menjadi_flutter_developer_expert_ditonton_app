import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_movie_recommendations.dart';

part 'all_the_movies_recommendations_state.dart';

class AllTheMovieRecommendationsCubit extends Cubit<AllTheMovieRecommendationsState> {
  AllTheMovieRecommendationsCubit({
    required this.getAllTheMovieRecommendations,
  }) : super(const AllTheMovieRecommendationsInitialState());
  final GetAllMovieRecommendations getAllTheMovieRecommendations;

  Future<void> fetchAllTheMovieRecommendationsCubit(int movies) async {
    emit(const AllTheMovieRecommendationsLoadingState());
    final theresult = await getAllTheMovieRecommendations.execute(movies);
    theresult.fold(
      (flr) => emit(AllTheMovieRecommendationsErrorState(flr.mssg)),
      (val) => emit(AllTheMovieRecommendationsLoadedState(movies: val)),
    );
  }
}
