import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  Movie({
    required this.adultMovie,
    required this.backdropPathMovie,
    required this.genreIdsMovie,
    required this.idMovie,
    required this.originalTitleMovie,
    required this.overviewMovie,
    required this.popularityMovie,
    required this.posterPathMovie,
    required this.releaseDateMovie,
    required this.titleMovie,
    required this.videoMovie,
    required this.voteAverageMovie,
    required this.voteCountMovie,
  });

  Movie.watchlist({
    required this.idMovie,
    required this.overviewMovie,
    required this.posterPathMovie,
    required this.titleMovie,
  });

  bool? adultMovie;
  String? backdropPathMovie;
  List<int>? genreIdsMovie;
  int idMovie;
  String? originalTitleMovie;
  String? overviewMovie;
  double? popularityMovie;
  String? posterPathMovie;
  String? releaseDateMovie;
  String? titleMovie;
  bool? videoMovie;
  double? voteAverageMovie;
  int? voteCountMovie;

  List<Object?> get props => [
        adultMovie,
        backdropPathMovie,
        genreIdsMovie,
        idMovie,
        originalTitleMovie,
        overviewMovie,
        popularityMovie,
        posterPathMovie,
        releaseDateMovie,
        titleMovie,
        videoMovie,
        voteAverageMovie,
        voteCountMovie,
      ];
}
