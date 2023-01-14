part of 'top_rated_tv_show_cubit.dart';

abstract class TopRatedTVShowState extends Equatable {
  const TopRatedTVShowState();

  @override
  List<Object> get props => [];
}

class TopRatedTVShowInitialState extends TopRatedTVShowState {
  const TopRatedTVShowInitialState();
}

class TopRatedTVShowLoadingState extends TopRatedTVShowState {
  const TopRatedTVShowLoadingState();
}

class TopRatedTVShowErrorState extends TopRatedTVShowState {
  const TopRatedTVShowErrorState(
    this.mssg,
  );

  final String mssg;

  @override
  List<Object> get props => [mssg];

  @override
  bool get strfy => true;

  TopRatedTVShowErrorState copyWith({
    String? mssg,
  }) {
    return TopRatedTVShowErrorState(
      mssg ?? this.mssg,
    );
  }
}

class TopRatedTVShowLoadedState extends TopRatedTVShowState {
  const TopRatedTVShowLoadedState({
    required this.tvShow,
  });

  final List<TVEntities> tvShow;

  @override
  List<Object> get props => [tvShow];

  @override
  bool get strfy => true;

  TopRatedTVShowLoadedState copyWith({
    List<TVEntities>? tvShow,
  }) {
    return TopRatedTVShowLoadedState(
      tvShow: tvShow ?? this.tvShow,
    );
  }
}
