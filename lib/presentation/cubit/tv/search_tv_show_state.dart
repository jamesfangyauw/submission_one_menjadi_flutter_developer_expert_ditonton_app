part of 'search_tv_show_bloc.dart';

abstract class SearchTVShowState extends Equatable {
  const SearchTVShowState();
  @override
  List<Object> get props => [];
}

class SearchTVShowInitial extends SearchTVShowState {}

class SearchTVShowLoading extends SearchTVShowState {}

class SearchTVShowLoaded extends SearchTVShowState {
  final List<TVEntities> tvShow;

  const SearchTVShowLoaded(this.tvShow);

  @override
  List<Object> get props => [tvShow];
}

class SearchTVShowError extends SearchTVShowState {
  final String mssg;

  const SearchTVShowError(this.mssg);

  @override
  List<Object> get props => [mssg];
}
