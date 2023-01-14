part of 'all_the_movies_details_cubit.dart';

class AllTheMovieDetailState extends Equatable {
  final MovieDetail movieDetail;
  final bool addToWatchlistIs;
  final String mssg;
  final String mssgWatchlist;
  final EnumStateRequest enumStateRequest;

  const AllTheMovieDetailState({
    this.movieDetail = const MovieDetail(),
    this.addToWatchlistIs = false,
    this.mssg = '',
    this.mssgWatchlist = '',
    this.enumStateRequest = EnumStateRequest.DataEmpty,
  });

  AllTheMovieDetailState setAllMovieDetail(MovieDetail movie) => copyWith(movieDetail: movie);
  AllTheMovieDetailState setAddMovieToWatchlist(bool value) => copyWith(addToWatchlistIs: value);
  AllTheMovieDetailState setEnumStateRequest(EnumStateRequest enumStateRequest) =>
      copyWith(enumStateRequest: enumStateRequest);
  AllTheMovieDetailState setMssg(String mssg) => copyWith(mssg: mssg);
  AllTheMovieDetailState setMssgWatchlist(String mssg) => copyWith(mssgWatchlist: mssg);

  @override
  List<Object> get props {
    return [
      movieDetail,
      addToWatchlistIs,
      mssg,
      mssgWatchlist,
      enumStateRequest,
    ];
  }

  @override
  bool get strfy => true;

  AllTheMovieDetailState copyWith({
    MovieDetail? movieDetail,
    bool? addToWatchlistIs,
    String? mssg,
    String? mssgWatchlist,
    EnumStateRequest? enumStateRequest,
  }) {
    return AllTheMovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      addToWatchlistIs: addToWatchlistIs ?? this.addToWatchlistIs,
      mssg: mssg ?? this.mssg,
      mssgWatchlist: mssgWatchlist ?? this.mssgWatchlist,
      enumStateRequest: enumStateRequest ?? this.enumStateRequest,
    );
  }
}