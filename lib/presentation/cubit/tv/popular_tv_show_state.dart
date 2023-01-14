part of 'popular_tv_show_cubit.dart';

abstract class PopularTVShowState extends Equatable {
  const PopularTVShowState();

  @override
  List<Object> get props => [];
}

class PopularTVShowInitialState extends PopularTVShowState {
  const PopularTVShowInitialState();
}

class PopularTVShowLoadingState extends PopularTVShowState {
  const PopularTVShowLoadingState();
}

class PopularTVShowErrorState extends PopularTVShowState {
  const PopularTVShowErrorState(
    this.mssg,
  );

  final String mssg;

  @override
  List<Object> get props => [mssg];

  @override
  bool get strfy => true;

  PopularTVShowErrorState copyWith({
    String? mssg,
  }) {
    return PopularTVShowErrorState(
      mssg ?? this.mssg,
    );
  }
}

class PopularTVShowLoadedState extends PopularTVShowState {
  const PopularTVShowLoadedState({
    required this.tvShow,
  });

  final List<TVEntities> tvShow;

  @override
  List<Object> get props => [tvShow];

  @override
  bool get strfy => true;

  PopularTVShowLoadedState copyWith({
    List<TVEntities>? tvShow,
  }) {
    return PopularTVShowLoadedState(
      tvShow: tvShow ?? this.tvShow,
    );
  }
}
