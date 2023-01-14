import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_the_movies_popular_state.dart';

class AllTheMoviePopularCubit extends Cubit<AllTheMoviePopularState> {
  AllTheMoviePopularCubit({
    required this.getAllThePopularMovies,
  }) : super(const AllTheMoviePopularInitialState());

  final GetAllPopularMovies getAllThePopularMovies;
  Future<void> fetchAllThePopularMovieCubit() async {
    emit(const AllTheMoviePopularLoadingState());

    final theresult = await getAllThePopularMovies.execute();

    theresult.fold(
      (flr) => emit(AllTheMoviePopularErrorState(flr.mssg)),
      (val) => emit(AllTheMoviePopularLoadedState(movies: val)),
    );
  }
}
