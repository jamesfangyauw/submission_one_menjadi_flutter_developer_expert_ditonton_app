import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_the_movies_watchlist_state.dart';

class AllTheMovieWatchlistCubit extends Cubit<AllTheMovieWatchlistState> {
  AllTheMovieWatchlistCubit({
    required this.getWatchlistAllTheMovies,
  }) : super(const AllTheMovieWatchlistInitialState());

  final GetAllWatchlistMovies getWatchlistAllTheMovies;

  Future<void> fetchAllTheMovieWatchlistCubit() async {
    emit(const AllTheMovieWatchlistLoadingState());
    final theresult = await getWatchlistAllTheMovies.execute();
    theresult.fold(
      (flr) => emit(AllTheMovieWatchlistErrorState(flr.mssg)),
      (val) => emit(AllTheMovieWatchlistLoadedState(movies: val)),
    );
  }
}
