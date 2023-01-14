part of 'all_the_movies_recommendations_cubit.dart';

abstract class AllTheMovieRecommendationsState extends Equatable {
  const AllTheMovieRecommendationsState();

  @override
  List<Object> get props => [];
}

class AllTheMovieRecommendationsInitialState extends AllTheMovieRecommendationsState {
  const AllTheMovieRecommendationsInitialState();
}

class AllTheMovieRecommendationsLoadingState extends AllTheMovieRecommendationsState {
  const AllTheMovieRecommendationsLoadingState();
}

class AllTheMovieRecommendationsErrorState extends AllTheMovieRecommendationsState {
  const AllTheMovieRecommendationsErrorState(
    this.mssg,
  );

  final String mssg;

  @override
  List<Object> get props => [mssg];

  @override
  bool get strfy => true;

  AllTheMovieRecommendationsErrorState copyWith({
    String? mssg,
  }) {
    return AllTheMovieRecommendationsErrorState(
      mssg ?? this.mssg,
    );
  }
}

class AllTheMovieRecommendationsLoadedState extends AllTheMovieRecommendationsState {
  const AllTheMovieRecommendationsLoadedState({
    required this.movies,
  });

  final List<Movie> movies;

  @override
  List<Object> get props => [movies];

  @override
  bool get strfy => true;

  AllTheMovieRecommendationsLoadedState copyWith({
    List<Movie>? movies,
  }) {
    return AllTheMovieRecommendationsLoadedState(
      movies: movies ?? this.movies,
    );
  }
}
