import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_movie_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/get_all_watchlist_status.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/remove_all_watchlist.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/save_all_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_the_movies_details_state.dart';

class AllTheMovieDetailCubit extends Cubit<AllTheMovieDetailState> {
  AllTheMovieDetailCubit({
    required this.getAllTheMovieDetail,
    required this.saveAllWatchlistTheMovies,
    required this.removeAllWatchlistTheMovies,
    required this.getAllWatchListTheMoviesStatus,
  }) : super(const AllTheMovieDetailState());

  final GetAllMovieDetail getAllTheMovieDetail;
  final SaveAllWatchListTheMovies saveAllWatchlistTheMovies;
  final RemoveAllWatchlistTheMovies removeAllWatchlistTheMovies;
  final GetAllWatchListTheMoviesStatus getAllWatchListTheMoviesStatus;

  static const mssgAddWatchlist = 'Added to Watchlist';
  static const mssgRemoveWatchlist = 'Removed from Watchlist';

  Future<void> fetchAllTheMoviesDetailsCubit(int idMovie) async {
    emit(state.setEnumStateRequest(EnumStateRequest.DataLoading));
    final theresult = await getAllTheMovieDetail.execute(idMovie);
    theresult.fold(
          (flr) {
        emit(
          AllTheMovieDetailState(
            enumStateRequest: EnumStateRequest.DataError,
            mssg: flr.mssg,
          ),
        );
      },
          (movie) async {
        emit(
          AllTheMovieDetailState(
            enumStateRequest: EnumStateRequest.DataLoaded,
            movieDetail : movie,
          ),
        );
      },
    );
  }

  Future<void> addWatchlistTheMovies(MovieDetail movie) async {
    final result = await saveAllWatchlistTheMovies.execute(movie);
    result.fold(
          // (failure) => emit(state.setMessageWatchlist(failure.mssg)),
          // (value) => emit(state.setMessageWatchlist(value)),
          (failure) async {
        emit(
          state.copyWith(
            mssgWatchlist: failure.mssg,
          ),
        );
      },
          (successMessage) async {
        emit(
          state.copyWith(
            mssgWatchlist: successMessage,
          ),
        );
      },
    );
    await getWatchlistStatus(movie.idMovie);
  }

  Future<void> deleteWatchlistTheMovies(MovieDetail movie) async {
    final result = await removeAllWatchlistTheMovies.execute(movie);
    result.fold(
          // (failure) => emit(state.setMessageWatchlist(failure.mssg)),
          // (value) => emit(state.setMessageWatchlist(value)),
          (failure) async {
        emit(
          state.copyWith(
            mssgWatchlist: failure.mssg,
          ),
        );
      },
          (successMessage) async {
        emit(
          state.copyWith(
            mssgWatchlist: successMessage,
          ),
        );
      },
    );
    await getWatchlistStatus(movie.idMovie);
  }

  Future<void> getWatchlistStatus(int id) async {
    final result = await getAllWatchListTheMoviesStatus.execute(id);
    emit(state.setAddMovieToWatchlist(result));
  }
}