part of 'all_the_movies_watchlist_cubit.dart';

abstract class AllTheMovieWatchlistState extends Equatable {
  const AllTheMovieWatchlistState();

  @override
  List<Object> get props => [];
}

class AllTheMovieWatchlistInitialState extends AllTheMovieWatchlistState {
  const AllTheMovieWatchlistInitialState();
}

class AllTheMovieWatchlistLoadingState extends AllTheMovieWatchlistState {
  const AllTheMovieWatchlistLoadingState();
}

class AllTheMovieWatchlistErrorState extends AllTheMovieWatchlistState {
  const AllTheMovieWatchlistErrorState(
    this.mssg,
  );

  final String mssg;

  @override
  List<Object> get props => [mssg];

  @override
  bool get strfy => true;

  AllTheMovieWatchlistErrorState copyWith({
    String? mssg,
  }) {
    return AllTheMovieWatchlistErrorState(
      mssg ?? this.mssg,
    );
  }
}

class AllTheMovieWatchlistLoadedState extends AllTheMovieWatchlistState {
  const AllTheMovieWatchlistLoadedState({
    required this.movies,
  });

  final List<Movie> movies;

  @override
  List<Object> get props => [movies];

  @override
  bool get strfy => true;

  AllTheMovieWatchlistLoadedState copyWith({
    List<Movie>? movies,
  }) {
    return AllTheMovieWatchlistLoadedState(
      movies: movies ?? this.movies,
    );
  }
}
