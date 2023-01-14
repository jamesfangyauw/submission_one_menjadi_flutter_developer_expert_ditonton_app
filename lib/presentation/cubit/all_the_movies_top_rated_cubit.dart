import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_top_rated_movies.dart';

part './all_the_movies_top_rated_state.dart';

class AllTheMovieTopRatedCubit extends Cubit<AllTheMovieTopRatedState> {
  AllTheMovieTopRatedCubit({
    required this.getTopRatedAllTheMovies,
  }) : super(const AllTheMovieTopRatedInitialState());

  final GetAllTopRatedMovies getTopRatedAllTheMovies;
  Future<void> fetchAllTheMovieTopRatedCubit() async {
    emit(const AllTheMovieTopRatedLoadingState());

    final theresult = await getTopRatedAllTheMovies.execute();
    theresult.fold(
      (flr) => emit(AllTheMovieTopRatedErrorState(flr.mssg)),
      (val) => emit(AllTheMovieTopRatedLoadedState(movies: val)),
    );
  }
}
