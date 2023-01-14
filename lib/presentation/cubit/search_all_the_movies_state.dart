part of 'search_all_the_movies_bloc.dart';

abstract class SearchAllTheMoviesState extends Equatable {
  const SearchAllTheMoviesState();

  @override
  List<Object> get props => [];
}

class SearchAllTheMoviesInitial extends SearchAllTheMoviesState {}

class SearchAllTheMoviesLoading extends SearchAllTheMoviesState {}

class SearchAllTheMoviesLoaded extends SearchAllTheMoviesState {
  final List<Movie> themovies;

  const SearchAllTheMoviesLoaded(this.themovies);

  @override
  List<Object> get props => [themovies];
}

class SearchAllTheMoviesError extends SearchAllTheMoviesState {
  final String mssg;

  const SearchAllTheMoviesError(this.mssg);

  @override
  List<Object> get props => [mssg];
}
