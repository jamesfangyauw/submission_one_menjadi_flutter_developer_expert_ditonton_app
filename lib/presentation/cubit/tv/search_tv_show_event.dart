part of 'search_tv_show_bloc.dart';

abstract class SearchTVShowEvent extends Equatable {
  const SearchTVShowEvent();
  @override
  List<Object> get props => [];
}
class SearchTVShowAction extends SearchTVShowEvent {
  final String thequery;

  const SearchTVShowAction(this.thequery);
  @override
  List<Object> get props => [thequery];
}
