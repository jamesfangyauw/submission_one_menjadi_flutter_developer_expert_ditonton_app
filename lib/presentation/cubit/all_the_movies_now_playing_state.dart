part of 'all_the_movies_now_playing_cubit.dart';

abstract class AllTheMovieNowPlayingState extends Equatable {
  const AllTheMovieNowPlayingState();
  @override
  List<Object> get props => [];
}

class AllTheMovieNowPlayingInitialState extends AllTheMovieNowPlayingState {
  const AllTheMovieNowPlayingInitialState();
}

class AllTheMovieNowPlayingLoadingState extends AllTheMovieNowPlayingState {
  const AllTheMovieNowPlayingLoadingState();
}

class AllTheMovieNowPlayingErrorState extends AllTheMovieNowPlayingState {
  const AllTheMovieNowPlayingErrorState(
      this.mssg,
      );

  final String mssg;

  @override
  List<Object> get props => [mssg];

  @override
  bool get strfy => true;

  AllTheMovieNowPlayingErrorState copyWith({
    String? mssg,
  }) {
    return AllTheMovieNowPlayingErrorState(
      mssg ?? this.mssg,
    );
  }
}

class AllTheMovieNowPlayingLoadedState extends AllTheMovieNowPlayingState {
  const AllTheMovieNowPlayingLoadedState({
    required this.movies,
  });

  final List<Movie> movies;

  @override
  List<Object> get props => [movies];

  @override
  bool get strfy => true;

  AllTheMovieNowPlayingLoadedState copyWith({
    List<Movie>? movies,
  }) {
    return AllTheMovieNowPlayingLoadedState(
      movies: movies ?? this.movies,
    );
  }
}
