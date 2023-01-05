import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/table_movie.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/genre_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/table_tv.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_detail.dart';
final testTheMovies = Movie(
  adultMovie: false,
  backdropPathMovie: '/sbajeIwjsls12Hawj12Hal82HajkwJ98.jpg',
  genreIdsMovie: [23, 17, 10, 05],
  idMovie: 771,
  originalTitleMovie: 'Avenger Infinity War',
  overviewMovie:
      'Having acquired the Power Stone–one of six Infinity Stones–from the planet Xandar, Thanos and his lieutenants: Ebony Maw, Cull Obsidian, Proxima Midnight, and Corvus Glaive, intercept the spaceship carrying the survivors of Asgar\'s destruction.[a] After subduing Thor, Thanos extracts the Space Stone from the Tesseract, overpowers the Hulk, and kills Loki. Thanos also kills Heimdall after he sends Hulk to Earth using the Bifröst. Thanos and his lieutenants leave, destroying the ship.Hulk crash-lands in the Sanctum Sanctorum in New York City, reverting to the form of Bruce Banner. He warns Stephen Strange and Wong about Thanos plan to destroy half of all life in the universe, and they recruit Tony Stark. Maw and Obsidian arrive to retrieve the Time Stone from Strange, drawing Peter Parker\'s attention. Maw, unable to take the Time Stone due to Strange\'s enchantment, captures him. Stark and Parker sneak aboard Maw\'s spaceship while Wong stays behind to guard the Sanctum.',
  popularityMovie: 75.678,
  posterPathMovie: '/eieLejaoeH12hakd883HKsldkeO34.jpg',
  releaseDateMovie: '2018-03-15',
  titleMovie: 'Avengers : Infinity War',
  videoMovie: false,
  voteAverageMovie: 8.0,
  voteCountMovie: 21384,
);

final testTheMovieList = [testTheMovies];

final testTheMovieDetail = MovieDetail(
  adultMovie: false,
  backdropPathMovie: 'MovieDetailBackdropPath',
  genresMovie: [GenreEntities(idGenre: 1, nameGenre: 'Action')],
  idMovie: 1,
  originalTitleMovie: 'originalTitle',
  overviewMovie: 'overview',
  posterPathMovie: 'posterPath',
  releaseDateMovie: 'releaseDate',
  runtimeMovie: 120,
  titleMovie: 'title',
  voteAverageMovie: 1,
  voteCountMovie: 1,
);

final testWatchlistAllMovie = Movie.watchlist(
  idMovie: 1,
  titleMovie: 'title',
  posterPathMovie: 'posterPath',
  overviewMovie: 'overview',
);

final testTheMovieTable = TableMovie(
  idMovie: 1,
  titleMovie: 'title',
  posterPathMovie: 'posterPath',
  overviewMovie: 'overview',
);

final testTheMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTVShow = TVEntities(
  pathBackdrop: '/sbajeIwjsls12Hawj12Hal82HajkwJ98.jpg',
  genreIdsTv: [23, 17, 10, 05],
  idTv: 771,
  name_original: 'Avenger Infinity War',
  tv_overview:
  'Having acquired the Power Stone–one of six Infinity Stones–from the planet Xandar, Thanos and his lieutenants: Ebony Maw, Cull Obsidian, Proxima Midnight, and Corvus Glaive, intercept the spaceship carrying the survivors of Asgar\'s destruction.[a] After subduing Thor, Thanos extracts the Space Stone from the Tesseract, overpowers the Hulk, and kills Loki. Thanos also kills Heimdall after he sends Hulk to Earth using the Bifröst. Thanos and his lieutenants leave, destroying the ship.Hulk crash-lands in the Sanctum Sanctorum in New York City, reverting to the form of Bruce Banner. He warns Stephen Strange and Wong about Thanos plan to destroy half of all life in the universe, and they recruit Tony Stark. Maw and Obsidian arrive to retrieve the Time Stone from Strange, drawing Peter Parker\'s attention. Maw, unable to take the Time Stone due to Strange\'s enchantment, captures him. Stark and Parker sneak aboard Maw\'s spaceship while Wong stays behind to guard the Sanctum.',
  tv_popularity: 75.678,
  path_poster: '/eieLejaoeH12hakd883HKsldkeO34.jpg',
  date_first_show: '2018-03-15',
  nameTv: 'Avengers : Infinity War',
  tv_voteAverage:8.0,
  tv_voteCount: 21384,
  language_original: 'en',
);

final testAllTVShowList = [testTVShow];

final testTVShowDetail = TVShowDetail(
  tvBckdropPath: "TVShowDetailBckDrpPath",
  tvGenres: [GenreEntities(idGenre: 1, nameGenre: "Action")],
  tvShowId: 1,
  tv_show_originame: "original_name",
  tvShowPopularityPublic: 1.0,
  tvShowOverview: "overview",
  tv_show_pstrpath: "posterPath",
  tv_first_release: "releaseDate",
  tv_show_name: "name",
  tv_show_voteAvg: 1,
  tv_show_voteCnt: 1,
  origlanguage_tv_show: "en",
);

final testWatchlistAllTVShow = TVEntities.watchlist(
  idTv: 1,
  nameTv: 'name',
  path_poster: 'posterPath',
  tv_overview: 'overview',
);

final testTVShowTable = TableTV(
  idTv: 1,
  nametv: "name",
  posterPathTv: "posterPath",
  overviewTv: "overview",
);

final testTVShowMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
