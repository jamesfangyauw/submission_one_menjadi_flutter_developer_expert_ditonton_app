part of 'search_all_the_movies_bloc.dart';

abstract class SearchAllTheMoviesEvent extends Equatable {
  const SearchAllTheMoviesEvent();

  @override
  List<Object> get props => [];
}
class SearchAllTheMoviesAction extends SearchAllTheMoviesEvent {
  final String thequery;

  const SearchAllTheMoviesAction(this.thequery);

  @override
  List<Object> get props => [thequery];
}
