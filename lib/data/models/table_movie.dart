import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class TableMovie extends Equatable {
  final int idMovie;
  final String? titleMovie;
  final String? posterPathMovie;
  final String? overviewMovie;

  TableMovie({
    required this.idMovie,
    required this.titleMovie,
    required this.posterPathMovie,
    required this.overviewMovie,
  });
  factory TableMovie.fromEntity(MovieDetail movie) => TableMovie(
        idMovie: movie.idMovie,
        titleMovie: movie.titleMovie,
        posterPathMovie: movie.posterPathMovie,
        overviewMovie: movie.overviewMovie,
      );
  factory TableMovie.fromMap(Map<String, dynamic> map) => TableMovie(
        idMovie: map['id'],
        titleMovie: map['title'],
        posterPathMovie: map['posterPath'],
        overviewMovie: map['overview'],
      );
  Map<String, dynamic> toJson() => {
        'id': idMovie,
        'title': titleMovie,
        'posterPath': posterPathMovie,
        'overview': overviewMovie,
      };
  Movie toEntity() => Movie.watchlist(
        idMovie: idMovie,
        overviewMovie: overviewMovie,
        posterPathMovie: posterPathMovie,
        titleMovie: titleMovie,
      );
  List<Object?> get props => [idMovie, titleMovie, posterPathMovie, overviewMovie];
}
