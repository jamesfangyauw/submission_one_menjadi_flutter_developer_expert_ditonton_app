import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/genre_entities.dart';
import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable {
  const MovieDetail({
     this.adultMovie = false ,
     this.backdropPathMovie,
     this.genresMovie = const [],
     this.idMovie = 0,
     this.originalTitleMovie = "",
     this.overviewMovie = "",
     this.posterPathMovie = "",
     this.releaseDateMovie = "",
     this.runtimeMovie = 0,
     this.titleMovie = "",
     this.voteAverageMovie = 0,
     this.voteCountMovie = 0,
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
