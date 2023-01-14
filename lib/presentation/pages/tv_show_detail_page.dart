import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/URL_BASE.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/color.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/genre_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/detail_tv_show_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/cubit/tv/recommendations_tv_show_cubit.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';


class TVShowDetailPage extends StatefulWidget {
  static const NAME_ROUTE = '/tv-show-detail';

  final int idTv;
  // TVShowDetailPage({required this.idTv});
  const TVShowDetailPage({Key? key, required this.idTv}) : super(key: key);
  @override
  _TVShowDetailPageState createState() => _TVShowDetailPageState();
}

class _TVShowDetailPageState extends State<TVShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // Provider.of<TVShowDetailNotifier>(context, listen: false)
      //     .fetchTVDetail(widget.idTv);
      // Provider.of<TVShowDetailNotifier>(context, listen: false)
      //     .tvShowLoadWatchlistStatus(widget.idTv);
      BlocProvider.of<DetailTVShowCubit>(context).fetchDetailTVShowCubit(widget.idTv);
    });
  }
  @override
  Widget build(BuildContext cntx) {
    return Scaffold(
      // body: Consumer<TVShowDetailNotifier>(
      //   builder: (cntxt, prvdr, chld) {
      //     if (prvdr.tvShowState == EnumStateRequest.DataLoading) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else if (prvdr.tvShowState == EnumStateRequest.DataLoaded) {
      //       final tvShow = prvdr.tvDetail;
      body: BlocBuilder<DetailTVShowCubit, DetailTVShowState>(
        builder: (cntxt, stt) {
          final enumRequestState = stt.enumStateRequest;

          if (enumRequestState == EnumStateRequest.DataLoading) {
            return CircularProgressIndicator();
          } else if (enumRequestState == EnumStateRequest.DataLoaded) {
            return SafeArea(
              // child: DetailContent(
              //   tvShow,
              //   prvdr.tvShowRecommendations,
              //   prvdr.tvShowAddedToWatchlist,
              // ),
              child: DetailTVShowContent(tvShowDetail: stt.tvShowDetail),
            );
          } else if (enumRequestState == EnumStateRequest.DataError) {
            return  Text(stt.mssg);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailTVShowContent extends StatefulWidget {
  final TVShowDetail tvShowDetail;
  // final List<TVEntities> tvShowRecommendations;
  // final bool isTvShowAddedWatchlist;
  // DetailContent(this.tvShowDetail, this.tvShowRecommendations, this.isTvShowAddedWatchlist);
  const DetailTVShowContent({Key? key, required this.tvShowDetail}) : super(key: key);

  @override
  State<DetailTVShowContent> createState() => _DetailTVShowContentState();
}

class _DetailTVShowContentState extends State<DetailTVShowContent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<RecommendationsTVShowCubit>(context)
          .fetchRecommendationsTVShowCubit(widget.tvShowDetail.tvShowId);
      context.read<DetailTVShowCubit>().getWatchlistStatusTVShow(widget.tvShowDetail.tvShowId);
    });
  }

  @override
  Widget build(BuildContext cntx) {
    final screenWidth = MediaQuery.of(cntx).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          // imageUrl: '$URL_BASE_IMAGE${tvShowDetail.tv_show_pstrpath}',
          imageUrl: '$URL_BASE_IMAGE${widget.tvShowDetail.tv_show_pstrpath}',
          width: screenWidth,
        //   placeholder: (cntxt, urlTv) => Center(
        //     child: CircularProgressIndicator(),
        //   ),
        //   errorWidget: (cont, urlErr, err) => Icon(Icons.error),
        // ),
          placeholder: (ctx, urlTv) => const Center(child: CircularProgressIndicator()),
          errorWidget: (ctx, urlTv, err) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (ctx, controllerscroll) {
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
                        controller: controllerscroll,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tvShowDetail.tv_show_name,
                              style: pHeading5,
                            ),
                            // ElevatedButton(
                            //   onPressed: () async {
                            //     if (!isTvShowAddedWatchlist) {
                            //       await Provider.of<TVShowDetailNotifier>(
                            //               ctx,
                            //               listen: false)
                            //           .addWatchlistTvShow(tvShowDetail);
                            //     } else {
                            //       await Provider.of<TVShowDetailNotifier>(
                            //               ctx,
                            //               listen: false)
                            //           .removeFromWatchlist(tvShowDetail);
                            //     }
                            //
                            //     final mssg =
                            //         Provider.of<TVShowDetailNotifier>(ctx,
                            //                 listen: false)
                            //             .tvShowWatchlistMessage;
                            //
                            //     if (mssg ==
                            //             TVShowDetailNotifier
                            //                 .watchlistTvShowAddSuccessMessage ||
                            //         mssg ==
                            //             TVShowDetailNotifier
                            //                 .watchlistTvShowRemoveSuccessMessage) {
                            //       ScaffoldMessenger.of(ctx).showSnackBar(
                            //           SnackBar(content: Text(mssg)));
                            //     } else {
                            //       showDialog(
                            //           context: ctx,
                            //           builder: (conten) {
                            //             return AlertDialog(
                            //               content: Text(mssg),
                            //             );
                            //           });
                            //     }
                            //   },
                            BlocBuilder<DetailTVShowCubit, DetailTVShowState>(
                              builder: (cntxt, stt) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    if (!stt.addWathclistIs) {
                                      await cntxt
                                          .read<DetailTVShowCubit>()
                                          .addWatchlistTVShow(widget.tvShowDetail);
                                    } else {
                                      await cntxt
                                          .read<DetailTVShowCubit>()
                                          .removeWatchlistTVShow(widget.tvShowDetail);
                                    }

                                    final mssg =
                                        cntxt.read<DetailTVShowCubit>().state.mssgWatchlist;

                                    if (mssg == DetailTVShowCubit.mssgAddWatchlist ||
                                        mssg == DetailTVShowCubit.mssgRemoveWatchlist) {
                                      ScaffoldMessenger.of(cntxt).hideCurrentSnackBar();
                                      ScaffoldMessenger.of(cntxt)
                                          .showSnackBar(
                                          SnackBar(
                                              content: Text(mssg),
                                              duration: const Duration(seconds: 2),
                                          ),
                                      );
                                    } else {
                                      showDialog(
                                        context: cntxt,
                                        builder: (contx) {
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
                                      stt.addWathclistIs
                                          ? const Icon(Icons.check)
                                          : const Icon(Icons.add),
                                      const Text('Watchlist'),
                                    ],
                                  ),
                                );
                              },
                              // child: Row(
                              //   mainAxisSize: MainAxisSize.min,
                              //   children: [
                              //     watchlistTvShowAddSuccessMessage
                              // ? Icon(Icons.check)
                              //     : Icon(Icons.add),
                              //     Text(WATCHLIST),
                              //   ],
                              // ),
                            ),
                            Text(
                              _showGenres(widget.tvShowDetail.tvGenres),
                            ),
                            // Text(
                            //   _showDuration(tv.runtime),
                            // ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tvShowDetail.tv_show_voteAvg / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: pMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tvShowDetail.tv_show_voteAvg}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              OVERVIEW,
                              style: pHeading6,
                            ),
                            Text(
                              widget.tvShowDetail.tvShowOverview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              RECOMEN,
                              style: pHeading6,
                            ),
                            // Consumer<TVShowDetailNotifier>(
                            //   builder: (cntxt, dt, chld) {
                            //     if (dt.tvShowRecommendationState ==
                            //         EnumStateRequest.DataLoading) {
                            //       return Center(
                            //         child: CircularProgressIndicator(),
                            //       );
                            //     } else if (dt.tvShowRecommendationState ==
                            //         EnumStateRequest.DataError) {
                            //       return Text(dt.mssg);
                            //     } else if (dt.tvShowRecommendationState ==
                            //         EnumStateRequest.DataLoaded) {
                            //       return Container(
                            BlocBuilder<RecommendationsTVShowCubit, RecommendationsTVShowState>(
                              builder: (cntxt, stt) {
                                if (stt is RecommendationsTVShowLoadingState) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (stt is RecommendationsTVShowErrorState) {
                                  return Text(stt.mssg);
                                } else if (stt is RecommendationsTVShowLoadedState) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (cont, idx) {
                                        final tvShow = stt.items[idx];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                cont,
                                                TVShowDetailPage.NAME_ROUTE,
                                                arguments: tvShow.idTv,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                // imageUrl:
                                                //     '$URL_BASE_IMAGE${tv.path_poster}',
                                                // placeholder: (context, url) =>
                                                //     Center(
                                                //   child:
                                                //       CircularProgressIndicator(),
                                                // ),
                                                imageUrl:
                                                '$URL_BASE_IMAGE${tvShow.path_poster}',
                                                placeholder: (contx, urlTv) => const Center(
                                                  child: CircularProgressIndicator(),
                                                ),
                                                errorWidget: (contx, urlTv, err) =>
                                                const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: stt.items.length,
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
  String _showGenres(List<GenreEntities> tvShowGenres) {
    String theresult = '';
    for (var genre in tvShowGenres) {
      theresult = theresult + genre.nameGenre + ', ';
    }

    if (theresult.isEmpty) {
      return theresult;
    }
    return theresult.substring(0, theresult.length - 2);
  }

  String? _chekResult (List<GenreEntities>tvShowGenres, String theresult){
    for (var genre in tvShowGenres) {
      theresult = theresult + genre.nameGenre + ', ';
    }
    if (theresult.isEmpty) {
      return theresult;
    }
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

}
