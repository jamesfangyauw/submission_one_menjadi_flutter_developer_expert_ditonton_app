import 'package:cached_network_image/cached_network_image.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/URL_BASE.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/genre_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/all_movie_detail_notifier.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/color.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_details_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/all_the_movies_recommendations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class AllMovieDetailPage extends StatefulWidget {
  static const NAME_ROUTE = '/movie-detail-page';
  final int idMovie;
  // AllMovieDetailPage({required this.idMovie});
  const AllMovieDetailPage({Key? thekey, required this.idMovie}) : super(key: thekey);

  @override
  _AllMovieDetailPageState createState() => _AllMovieDetailPageState();
}

class _AllMovieDetailPageState extends State<AllMovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<AllTheMovieDetailCubit>(context).fetchAllTheMoviesDetailsCubit(widget.idMovie);
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: BlocBuilder<AllTheMovieDetailCubit, AllTheMovieDetailState>(
        builder: (context, state) {
          final enumStateRequest = state.enumStateRequest;

          if (enumStateRequest == EnumStateRequest.DataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (enumStateRequest == EnumStateRequest.DataLoaded) {
            return SafeArea(
              // child: DetailContent(
              //   movie,
              //   prvdr.movieRecommendations,
              //   prvdr.isAddedToWatchlist,
              // ),
              child: DetailContent(themovie: state.movieDetail),
            );
          } else if (enumStateRequest == EnumStateRequest.DataError) {
            return Center(child: Text(state.mssg,style: TextStyle(color:Colors.white),));
          } else {
            return const Center(child: Text('error else',style: TextStyle(color:Colors.white),));
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final MovieDetail themovie;
  // final List<Movie> movierecommendations;
  // final bool addedWatchlistIs;

  const DetailContent({Key? key, required this.themovie}) : super(key: key);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AllTheMovieDetailCubit>().getWatchlistStatus(widget.themovie.idMovie);
      BlocProvider.of<AllTheMovieRecommendationsCubit>(context)
          .fetchAllTheMovieRecommendationsCubit(widget.themovie.idMovie);
    });
  }

  @override
  Widget build(BuildContext cntx) {
    final screenWidth = MediaQuery.of(cntx).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.themovie.posterPathMovie}',
          width: screenWidth,
          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (ctx, controlerScroll) {
              return Container(
                decoration: const BoxDecoration(
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
                              widget.themovie.titleMovie,
                              style: pHeading5,
                            ),
                            // ElevatedButton(
                            //   onPressed: () async {
                            //     if (!addedWatchlistIs) {
                            //       await Provider.of<AllMovieDetailNotifier>(
                            //               ctx,
                            //               listen: false)
                            //           .addWatchlist(themovie);
                            //     } else {
                            //       await Provider.of<AllMovieDetailNotifier>(
                            //               ctx,
                            //               listen: false)
                            //           .removeFromWatchlist(themovie);
                            //     }
                            //
                            //     final mssg =
                            //         Provider.of<AllMovieDetailNotifier>(ctx,
                            //                 listen: false)
                            //             .watchlistMessage;
                            //     if (mssg ==
                            //             AllMovieDetailNotifier
                            //                 .watchlistAddSuccessMessage ||
                            //         mssg ==
                            //             AllMovieDetailNotifier
                            //                 .watchlistRemoveSuccessMessage) {
                            //       ScaffoldMessenger.of(ctx).showSnackBar(
                            //           SnackBar(content: Text(mssg)));
                            //     } else {
                            //       showDialog(
                            //           context: ctx,
                            //           builder: (context) {
                            //             return AlertDialog(
                            //               content: Text(mssg),
                            //             );
                            //           });
                            //     }
                            //   },
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       addedWatchlistIs
                            //           ? Icon(Icons.check)
                            //           : Icon(Icons.add),
                            //       Text(WATCHLIST),
                            //     ],
                            //   ),
                            BlocBuilder<AllTheMovieDetailCubit, AllTheMovieDetailState>(
                              builder: (cntex, stt) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    if (!stt.addToWatchlistIs) {
                                      await cntex
                                          .read<AllTheMovieDetailCubit>()
                                          .addWatchlistTheMovies(widget.themovie);
                                    } else {
                                      await cntex
                                          .read<AllTheMovieDetailCubit>()
                                          .deleteWatchlistTheMovies(widget.themovie);
                                    }

                                    final mssg =
                                        cntex.read<AllTheMovieDetailCubit>().state.mssgWatchlist;

                                    if (mssg == AllTheMovieDetailCubit.mssgAddWatchlist ||
                                        mssg == AllTheMovieDetailCubit.mssgRemoveWatchlist) {
                                      ScaffoldMessenger.of(cntex).hideCurrentSnackBar();
                                      ScaffoldMessenger.of(cntex)
                                          .showSnackBar(
                                          SnackBar(
                                            content: Text(mssg),
                                            duration: const Duration(seconds: 2),
                                          ),
                                      );
                                    } else {
                                      showDialog(
                                        context: cntex,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(mssg),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      stt.addToWatchlistIs
                                          ? const Icon(Icons.check)
                                          : const Icon(Icons.add),
                                      const Text('Watchlist'),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Text(
                              _showGenres(widget.themovie.genresMovie),
                            ),
                            Text(
                              _showDuration(widget.themovie.runtimeMovie),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.themovie.voteAverageMovie / 2,
                                  itemCount: 5,
                                  itemBuilder: (cntnt, idx) => const Icon(
                                    Icons.star,
                                    color: pMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.themovie.voteAverageMovie}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: pHeading6,
                            ),
                            Text(
                              widget.themovie.overviewMovie,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: pHeading6,
                            ),
                            // Consumer<AllMovieDetailNotifier>(
                            //   builder: (cntex, dt, chld) {
                            //     if (dt.recommendationState ==
                            //         EnumStateRequest.DataLoading) {
                            //       return Center(
                            //         child: CircularProgressIndicator(),
                            //       );
                            //     } else if (dt.recommendationState ==
                            //         EnumStateRequest.DataError) {
                            //       return Text(dt.msgge);
                            //     } else if (dt.recommendationState ==
                            //         EnumStateRequest.DataLoaded) {
                            //       return Container(
                            BlocBuilder<AllTheMovieRecommendationsCubit, AllTheMovieRecommendationsState>(
                              builder: (cntex, stt) {
                                if (stt is AllTheMovieRecommendationsLoadingState) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (stt is AllTheMovieRecommendationsErrorState) {
                                  return Text(stt.mssg);
                                } else if (stt is AllTheMovieRecommendationsLoadedState) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (cont, idx) {
                                        final themovie = stt.movies[idx];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                cont,
                                                AllMovieDetailPage.NAME_ROUTE,
                                                arguments: themovie.idMovie,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                '${URL_BASE_IMAGE}${themovie.posterPathMovie}',
                                                placeholder: (cntxt, urlMovie) => const Center(
                                                  child: CircularProgressIndicator(),
                                                ),
                                                errorWidget: (cntxt, urlMovie, err) =>
                                                const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: stt.movies.length,
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
              icon: const Icon(Icons.arrow_back),
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
