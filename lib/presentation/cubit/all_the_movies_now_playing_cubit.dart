import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_the_movies_now_playing_state.dart';

class AllTheMovieNowPlayingCubit extends Cubit<AllTheMovieNowPlayingState> {
  AllTheMovieNowPlayingCubit({
    required this.getNowPlayingAllTheMovies,
  }) : super(const AllTheMovieNowPlayingInitialState());

  final GetAllNowPlayingMovies getNowPlayingAllTheMovies;
  Future<void> fetchAllTheMovieNowPlayingCubit() async {
    emit(const AllTheMovieNowPlayingLoadingState());

    final theresult = await getNowPlayingAllTheMovies.execute();
    theresult.fold(
          (flr) => emit(AllTheMovieNowPlayingErrorState(flr.mssg)),
          (val) => emit(AllTheMovieNowPlayingLoadedState(movies: val)),
    );
  }
}
