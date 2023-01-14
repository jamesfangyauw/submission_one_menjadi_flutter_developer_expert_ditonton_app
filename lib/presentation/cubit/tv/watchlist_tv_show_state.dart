part of 'watchlist_tv_show_cubit.dart';
abstract class WatchlistTVShowState extends Equatable {
  const WatchlistTVShowState();

  @override
  List<Object> get props => [];
}

class WatchlistTVShowInitialState extends WatchlistTVShowState {
  const WatchlistTVShowInitialState();
}

class WatchlistLoadingTVShowState extends WatchlistTVShowState {
  const WatchlistLoadingTVShowState();
}

class WatchlistTVShowErrorState extends WatchlistTVShowState {
  const WatchlistTVShowErrorState(
    this.mssg,
  );

  final String mssg;

  @override
  List<Object> get props => [mssg];

  @override
  bool get strfy => true;

  WatchlistTVShowErrorState copyWith({
    String? mssg,
  }) {
    return WatchlistTVShowErrorState(
      mssg ?? this.mssg,
    );
  }
}

class WatchlistTVShowLoadedState extends WatchlistTVShowState {
  const WatchlistTVShowLoadedState({
    required this.tvShow,
  });

  final List<TVEntities> tvShow;

  @override
  List<Object> get props => [tvShow];

  @override
  bool get strfy => true;

  WatchlistTVShowLoadedState copyWith({
    List<TVEntities>? tvShow,
  }) {
    return WatchlistTVShowLoadedState(
      tvShow: tvShow ?? this.tvShow,
    );
  }
}
