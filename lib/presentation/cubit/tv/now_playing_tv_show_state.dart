part of 'now_playing_tv_show_cubit.dart';

abstract class NowPlayingTVShowState extends Equatable {
  const NowPlayingTVShowState();
  @override
  List<Object> get props => [];
}
class NowPlayingTVShowInitialState extends NowPlayingTVShowState {
  const NowPlayingTVShowInitialState();
}

class NowPlayingTVShowLoadingState extends NowPlayingTVShowState {
  const NowPlayingTVShowLoadingState();
}

class NowPlayingTVShowErrorState extends NowPlayingTVShowState {
  const NowPlayingTVShowErrorState(
      this.mssg,
      );

  final String mssg;

  @override
  List<Object> get props => [mssg];

  @override
  bool get strfy => true;

  NowPlayingTVShowErrorState copyWith({
    String? mssg,
  }) {
    return NowPlayingTVShowErrorState(
      mssg ?? this.mssg,
    );
  }
}
class NowPlayingTVShowLoadedState extends NowPlayingTVShowState {
  const NowPlayingTVShowLoadedState({
    required this.tvShow,
  });

  final List<TVEntities> tvShow;
  @override
  List<Object> get props => [tvShow];

  @override
  bool get strfy => true;

  NowPlayingTVShowLoadedState copyWith({
    List<TVEntities>? tvShow,
  }) {
    return NowPlayingTVShowLoadedState(
      tvShow: tvShow ?? this.tvShow,
    );
  }
}
