import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_movie.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieModel = ModelMovie(
    adultMovie: false,
    backdropPathMovie: 'backdropPath',
    genreIdsMovie: [1, 2, 3],
    idMovie: 1,
    originalTitleMovie: 'originalTitle',
    overviewMovie: 'overview',
    popularityMovie: 1,
    posterPathMovie: 'posterPath',
    releaseDateMovie: 'releaseDate',
    titleMovie: 'title',
    videoMovie: false,
    voteAverageMovie: 1,
    voteCountMovie: 1,
  );

  final tMovie = Movie(
    adultMovie: false,
    backdropPathMovie: 'backdropPath',
    genreIdsMovie: [1, 2, 3],
    idMovie: 1,
    originalTitleMovie: 'originalTitle',
    overviewMovie: 'overview',
    popularityMovie: 1,
    posterPathMovie: 'posterPath',
    releaseDateMovie: 'releaseDate',
    titleMovie: 'title',
    videoMovie: false,
    voteAverageMovie: 1,
    voteCountMovie: 1,
  );

  test('should be a subclass of Movie entity', () async {
    final theresult = tMovieModel.toEntity();
    expect(theresult, tMovie);
  });
}
