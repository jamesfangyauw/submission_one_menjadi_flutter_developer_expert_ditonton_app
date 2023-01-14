part of 'all_the_movies_popular_cubit.dart';

abstract class AllTheMoviePopularState extends Equatable {
  const AllTheMoviePopularState();

  @override
  List<Object> get props => [];
}

class AllTheMoviePopularInitialState extends AllTheMoviePopularState {
  const AllTheMoviePopularInitialState();
}

class AllTheMoviePopularLoadingState extends AllTheMoviePopularState {
  const AllTheMoviePopularLoadingState();
}

class AllTheMoviePopularErrorState extends AllTheMoviePopularState {
  const AllTheMoviePopularErrorState(
    this.mssg,
  );

  final String mssg;

  @override
  List<Object> get props => [mssg];

  @override
  bool get strfy => true;

  AllTheMoviePopularErrorState copyWith({
    String? mssg,
  }) {
    return AllTheMoviePopularErrorState(
      mssg ?? this.mssg,
    );
  }
}

class AllTheMoviePopularLoadedState extends AllTheMoviePopularState {
  const AllTheMoviePopularLoadedState({
    required this.movies,
  });

  final List<Movie> movies;

  @override
  List<Object> get props => [movies];

  @override
  bool get strfy => true;

  AllTheMoviePopularLoadedState copyWith({
    List<Movie>? movies,
  }) {
    return AllTheMoviePopularLoadedState(
      movies: movies ?? this.movies,
    );
  }
}
