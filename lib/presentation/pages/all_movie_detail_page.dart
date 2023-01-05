import 'package:cached_network_image/cached_network_image.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/URL_BASE.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/genre_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/all_movie_detail_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class AllMovieDetailPage extends StatefulWidget {
  static const NAME_ROUTE = '/movie-detail-page';
  final int idtv;
  AllMovieDetailPage({required this.idtv});

  @override
  _AllMovieDetailPageState createState() => _AllMovieDetailPageState();
}

class _AllMovieDetailPageState extends State<AllMovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AllMovieDetailNotifier>(context, listen: false)
          .fetchMovieDetail(widget.idtv);
      Provider.of<AllMovieDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.idtv);
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: Consumer<AllMovieDetailNotifier>(
        builder: (cntx, prvdr, chld) {
          if (prvdr.movieState == EnumStateRequest.DataLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (prvdr.movieState == EnumStateRequest.DataLoaded) {
            final movie = prvdr.movie;
            return SafeArea(
              child: DetailContent(
                movie,
                prvdr.movieRecommendations,
                prvdr.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(prvdr.msgge);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail themovie;
  final List<Movie> movierecommendations;
  final bool addedWatchlistIs;

  DetailContent(this.themovie, this.movierecommendations, this.addedWatchlistIs);

  @override
  Widget build(BuildContext cntx) {
    final screenWidth = MediaQuery.of(cntx).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '${URL_BASE_IMAGE}${themovie.posterPathMovie}',
          width: screenWidth,
          placeholder: (ctx, urlBase) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (ctx, urlBase, errorMsg) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (ctx, controlerScroll) {
              return Container(
                decoration: BoxDecoration(
                  color: black,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: controlerScroll,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              themovie.titleMovie,
                              style: pHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!addedWatchlistIs) {
                                  await Provider.of<AllMovieDetailNotifier>(
                                          ctx,
                                          listen: false)
                                      .addWatchlist(themovie);
                                } else {
                                  await Provider.of<AllMovieDetailNotifier>(
                                          ctx,
                                          listen: false)
                                      .removeFromWatchlist(themovie);
                                }

                                final mssg =
                                    Provider.of<AllMovieDetailNotifier>(ctx,
                                            listen: false)
                                        .watchlistMessage;
                                if (mssg ==
                                        AllMovieDetailNotifier
                                            .watchlistAddSuccessMessage ||
                                    mssg ==
                                        AllMovieDetailNotifier
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(ctx).showSnackBar(
                                      SnackBar(content: Text(mssg)));
                                } else {
                                  showDialog(
                                      context: ctx,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(mssg),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  addedWatchlistIs
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text(WATCHLIST),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(themovie.genresMovie),
                            ),
                            Text(
                              _showDuration(themovie.runtimeMovie),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: themovie.voteAverageMovie / 2,
                                  itemCount: 5,
                                  itemBuilder: (cntnt, idx) => Icon(
                                    Icons.star,
                                    color: pMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${themovie.voteAverageMovie}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: pHeading6,
                            ),
                            Text(
                              themovie.overviewMovie,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: pHeading6,
                            ),
                            Consumer<AllMovieDetailNotifier>(
                              builder: (cntxt, dt, chld) {
                                if (dt.recommendationState ==
                                    EnumStateRequest.DataLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (dt.recommendationState ==
                                    EnumStateRequest.DataError) {
                                  return Text(dt.msgge);
                                } else if (dt.recommendationState ==
                                    EnumStateRequest.DataLoaded) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (cont, idx) {
                                        final movie = movierecommendations[idx];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                cont,
                                                AllMovieDetailPage.NAME_ROUTE,
                                                arguments: movie.idMovie,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '${URL_BASE_IMAGE}${movie.posterPathMovie}',
                                                placeholder: (conten, urlBase) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (contextErr, urlErr, err) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: movierecommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: black,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(cntx);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<GenreEntities> thegenres) {
    String theresult = '';
    for (var genreMovie in thegenres) {
      theresult = theresult + genreMovie.nameGenre + ', ';
    }
    if (theresult.isEmpty) {
      return theresult;
    }
    return theresult.substring(0, theresult.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  String? _chekResult(String result, List<GenreEntities> thegenres){
    for (var genre in thegenres) {
      result = result + genre.nameGenre + ', ';
    }
    if (result.isEmpty) {
      return result;
    }
  }
}
