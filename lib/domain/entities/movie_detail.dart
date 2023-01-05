import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/genre_entities.dart';
import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable {
  MovieDetail({
    required this.adultMovie,
    required this.backdropPathMovie,
    required this.genresMovie,
    required this.idMovie,
    required this.originalTitleMovie,
    required this.overviewMovie,
    required this.posterPathMovie,
    required this.releaseDateMovie,
    required this.runtimeMovie,
    required this.titleMovie,
    required this.voteAverageMovie,
    required this.voteCountMovie,
  });

  final bool adultMovie;
  final String? backdropPathMovie;
  final List<GenreEntities> genresMovie;
  final int idMovie;
  final String originalTitleMovie;
  final String overviewMovie;
  final String posterPathMovie;
  final String releaseDateMovie;
  final int runtimeMovie;
  final String titleMovie;
  final double voteAverageMovie;
  final int voteCountMovie;

  List<Object?> get props => [
        adultMovie,
        backdropPathMovie,
        genresMovie,
        idMovie,
        originalTitleMovie,
        overviewMovie,
        posterPathMovie,
        releaseDateMovie,
        titleMovie,
        voteAverageMovie,
        voteCountMovie,
      ];
}
