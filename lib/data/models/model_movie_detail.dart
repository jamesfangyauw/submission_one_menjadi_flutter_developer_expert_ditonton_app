import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_genre.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class ModelMovieDetailResponse extends Equatable {
  ModelMovieDetailResponse({
    required this.adultMovie,
    required this.backdropPathMovie,
    required this.budgetMovie,
    required this.genresMovie,
    required this.homepageMovie,
    required this.idMovie,
    required this.imdbIdMovie,
    required this.originalLanguageMovie,
    required this.originalTitleMovie,
    required this.overviewMovie,
    required this.popularityMovie,
    required this.posterPathMovie,
    required this.releaseDateMovie,
    required this.revenueMovie,
    required this.runtimeMovie,
    required this.statusMovie,
    required this.taglineMovie,
    required this.titleMovie,
    required this.videoMovie,
    required this.voteAverageMovie,
    required this.voteCountMovie,
  });

  final bool adultMovie;
  final String? backdropPathMovie;
  final int budgetMovie;
  final List<ModelGenre> genresMovie;
  final String homepageMovie;
  final int idMovie;
  final String? imdbIdMovie;
  final String originalLanguageMovie;
  final String originalTitleMovie;
  final String overviewMovie;
  final double popularityMovie;
  final String posterPathMovie;
  final String releaseDateMovie;
  final int revenueMovie;
  final int runtimeMovie;
  final String statusMovie;
  final String taglineMovie;
  final String titleMovie;
  final bool videoMovie;
  final double voteAverageMovie;
  final int voteCountMovie;

  factory ModelMovieDetailResponse.fromJson(Map<String, dynamic> json) =>
      ModelMovieDetailResponse(
        adultMovie: json["adult"],
        backdropPathMovie: json["backdrop_path"],
        budgetMovie: json["budget"],
        genresMovie: List<ModelGenre>.from(
            json["genres"].map((x) => ModelGenre.fromJson(x))),
        homepageMovie: json["homepage"],
        idMovie: json["id"],
        imdbIdMovie: json["imdb_id"],
        originalLanguageMovie: json["original_language"],
        originalTitleMovie: json["original_title"],
        overviewMovie: json["overview"],
        popularityMovie: json["popularity"].toDouble(),
        posterPathMovie: json["poster_path"],
        releaseDateMovie: json["release_date"],
        revenueMovie: json["revenue"],
        runtimeMovie: json["runtime"],
        statusMovie: json["status"],
        taglineMovie: json["tagline"],
        titleMovie: json["title"],
        videoMovie: json["video"],
        voteAverageMovie: json["vote_average"].toDouble(),
        voteCountMovie: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adultMovie,
        "backdrop_path": backdropPathMovie,
        "budget": budgetMovie,
        "genres": List<dynamic>.from(genresMovie.map((x) => x.toJson())),
        "homepage": homepageMovie,
        "id": idMovie,
        "imdb_id": imdbIdMovie,
        "original_language": originalLanguageMovie,
        "original_title": originalTitleMovie,
        "overview": overviewMovie,
        "popularity": popularityMovie,
        "poster_path": posterPathMovie,
        "release_date": releaseDateMovie,
        "revenue": revenueMovie,
        "runtime": runtimeMovie,
        "status": statusMovie,
        "tagline": taglineMovie,
        "title": titleMovie,
        "video": videoMovie,
        "vote_average": voteAverageMovie,
        "vote_count": voteCountMovie,
      };

  MovieDetail toEntity() {
    return MovieDetail(
      adultMovie: this.adultMovie,
      backdropPathMovie: this.backdropPathMovie,
      genresMovie: this.genresMovie.map((genre) => genre.toEntity()).toList(),
      idMovie: this.idMovie,
      originalTitleMovie: this.originalTitleMovie,
      overviewMovie: this.overviewMovie,
      posterPathMovie: this.posterPathMovie,
      releaseDateMovie: this.releaseDateMovie,
      runtimeMovie: this.runtimeMovie,
      titleMovie: this.titleMovie,
      voteAverageMovie: this.voteAverageMovie,
      voteCountMovie: this.voteCountMovie,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        adultMovie,
        backdropPathMovie,
        budgetMovie,
        genresMovie,
        homepageMovie,
        idMovie,
        imdbIdMovie,
        originalLanguageMovie,
        originalTitleMovie,
        overviewMovie,
        popularityMovie,
        posterPathMovie,
        releaseDateMovie,
        revenueMovie,
        runtimeMovie,
        statusMovie,
        taglineMovie,
        titleMovie,
        videoMovie,
        voteAverageMovie,
        voteCountMovie,
      ];
}
