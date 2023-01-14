part of 'all_the_movies_top_rated_cubit.dart';

abstract class AllTheMovieTopRatedState extends Equatable {
  const AllTheMovieTopRatedState();

  @override
  List<Object> get props => [];
}

class AllTheMovieTopRatedInitialState extends AllTheMovieTopRatedState {
  const AllTheMovieTopRatedInitialState();
}

class AllTheMovieTopRatedLoadingState extends AllTheMovieTopRatedState {
  const AllTheMovieTopRatedLoadingState();
}

class AllTheMovieTopRatedErrorState extends AllTheMovieTopRatedState {
  const AllTheMovieTopRatedErrorState(
    this.mssg,
  );

  final String mssg;

  @override
  List<Object> get props => [mssg];

  @override
  bool get strfy => true;

  AllTheMovieTopRatedErrorState copyWith({
    String? mssg,
  }) {
    return AllTheMovieTopRatedErrorState(
      mssg ?? this.mssg,
    );
  }
}

class AllTheMovieTopRatedLoadedState extends AllTheMovieTopRatedState {
  const AllTheMovieTopRatedLoadedState({
    required this.movies,
  });

  final List<Movie> movies;

  @override
  List<Object> get props => [movies];

  @override
  bool get strfy => true;

  AllTheMovieTopRatedLoadedState copyWith({
    List<Movie>? movies,
  }) {
    return AllTheMovieTopRatedLoadedState(
      movies: movies ?? this.movies,
    );
  }
}
