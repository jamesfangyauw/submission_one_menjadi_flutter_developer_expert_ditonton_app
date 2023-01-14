part of 'recommendations_tv_show_cubit.dart';

abstract class RecommendationsTVShowState extends Equatable {
  const RecommendationsTVShowState();
  @override
  List<Object> get props => [];
}
class RecommendationsTVShowInitialState extends RecommendationsTVShowState {
  const RecommendationsTVShowInitialState();
}

class RecommendationsTVShowLoadingState extends RecommendationsTVShowState {
  const RecommendationsTVShowLoadingState();
}

class RecommendationsTVShowErrorState extends RecommendationsTVShowState {
  const RecommendationsTVShowErrorState(
    this.mssg,
  );

  final String mssg;

  @override
  List<Object> get props => [mssg];

  @override
  bool get strfy => true;

  RecommendationsTVShowErrorState copyWith({
    String? mssg,
  }) {
    return RecommendationsTVShowErrorState(
      mssg ?? this.mssg,
    );
  }
}

class RecommendationsTVShowLoadedState extends RecommendationsTVShowState {
  const RecommendationsTVShowLoadedState({
    required this.items,
  });

  final List<TVEntities> items;

  @override
  List<Object> get props => [items];

  @override
  bool get strfy => true;

  RecommendationsTVShowLoadedState copyWith({
    List<TVEntities>? items,
  }) {
    return RecommendationsTVShowLoadedState(
      items: items ?? this.items,
    );
  }
}
