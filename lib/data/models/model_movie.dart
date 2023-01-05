import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:equatable/equatable.dart';

class ModelMovie extends Equatable {
  ModelMovie({
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

  final bool adultMovie;
  final String? backdropPathMovie;
  final List<int> genreIdsMovie;
  final int idMovie;
  final String originalTitleMovie;
  final String overviewMovie;
  final double popularityMovie;
  final String? posterPathMovie;
  final String? releaseDateMovie;
  final String titleMovie;
  final bool videoMovie;
  final double voteAverageMovie;
  final int voteCountMovie;

  factory ModelMovie.fromJson(Map<String, dynamic> json) => ModelMovie(
        adultMovie: json["adult"],
        backdropPathMovie: json["backdrop_path"],
        genreIdsMovie: List<int>.from(json["genre_ids"].map((x) => x)),
        idMovie: json["id"],
        originalTitleMovie: json["original_title"],
        overviewMovie: json["overview"],
        popularityMovie: json["popularity"].toDouble(),
        posterPathMovie: json["poster_path"],
        releaseDateMovie: json["release_date"],
        titleMovie: json["title"],
        videoMovie: json["video"],
        voteAverageMovie: json["vote_average"].toDouble(),
        voteCountMovie: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adultMovie,
        "backdrop_path": backdropPathMovie,
        "genre_ids": List<dynamic>.from(genreIdsMovie.map((x) => x)),
        "id": idMovie,
        "original_title": originalTitleMovie,
        "overview": overviewMovie,
        "popularity": popularityMovie,
        "poster_path": posterPathMovie,
        "release_date": releaseDateMovie,
        "title": titleMovie,
        "video": videoMovie,
        "vote_average": voteAverageMovie,
        "vote_count": voteCountMovie,
      };

  Movie toEntity() {
    return Movie(
      adultMovie: this.adultMovie,
      backdropPathMovie: this.backdropPathMovie,
      genreIdsMovie: this.genreIdsMovie,
      idMovie: this.idMovie,
      originalTitleMovie: this.originalTitleMovie,
      overviewMovie: this.overviewMovie,
      popularityMovie: this.popularityMovie,
      posterPathMovie: this.posterPathMovie,
      releaseDateMovie: this.releaseDateMovie,
      titleMovie: this.titleMovie,
      videoMovie: this.videoMovie,
      voteAverageMovie: this.voteAverageMovie,
      voteCountMovie: this.voteCountMovie,
    );
  }

  @override
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
