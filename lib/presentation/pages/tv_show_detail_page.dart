import 'package:cached_network_image/cached_network_image.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/URL_BASE.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/color.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/genre_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/request_state_enum.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/provider/tv/tv_show_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';


class TVShowDetailPage extends StatefulWidget {
  static const NAME_ROUTE = '/tv-show-detail';

  final int idTv;
  TVShowDetailPage({required this.idTv});

  @override
  _TVShowDetailPageState createState() => _TVShowDetailPageState();
}

class _TVShowDetailPageState extends State<TVShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TVShowDetailNotifier>(context, listen: false)
          .fetchTVDetail(widget.idTv);
      Provider.of<TVShowDetailNotifier>(context, listen: false)
          .tvShowLoadWatchlistStatus(widget.idTv);
    });
  }
  @override
  Widget build(BuildContext cntx) {
    return Scaffold(
      body: Consumer<TVShowDetailNotifier>(
        builder: (cntxt, prvdr, chld) {
          if (prvdr.tvShowState == EnumStateRequest.DataLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (prvdr.tvShowState == EnumStateRequest.DataLoaded) {
            final tvShow = prvdr.tvDetail;
            return SafeArea(
              child: DetailContent(
                tvShow,
                prvdr.tvShowRecommendations,
                prvdr.tvShowAddedToWatchlist,
              ),
            );
          } else {
            return Text(prvdr.mssg);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TVShowDetail tvShowDetail;
  final List<TVEntities> tvShowRecommendations;
  final bool isTvShowAddedWatchlist;

  DetailContent(this.tvShowDetail, this.tvShowRecommendations, this.isTvShowAddedWatchlist);

  @override
  Widget build(BuildContext cntx) {
    final screenWidth = MediaQuery.of(cntx).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$URL_BASE_IMAGE${tvShowDetail.tv_show_pstrpath}',
          width: screenWidth,
          placeholder: (cntxt, urlTv) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (cont, urlErr, err) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (ctx, controllerscroll) {
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
                        controller: controllerscroll,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvShowDetail.tv_show_name,
                              style: pHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isTvShowAddedWatchlist) {
                                  await Provider.of<TVShowDetailNotifier>(
                                          ctx,
                                          listen: false)
                                      .addWatchlistTvShow(tvShowDetail);
                                } else {
                                  await Provider.of<TVShowDetailNotifier>(
                                          ctx,
                                          listen: false)
                                      .removeFromWatchlist(tvShowDetail);
                                }

                                final mssg =
                                    Provider.of<TVShowDetailNotifier>(ctx,
                                            listen: false)
                                        .tvShowWatchlistMessage;

                                if (mssg ==
                                        TVShowDetailNotifier
                                            .watchlistTvShowAddSuccessMessage ||
                                    mssg ==
                                        TVShowDetailNotifier
                                            .watchlistTvShowRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(ctx).showSnackBar(
                                      SnackBar(content: Text(mssg)));
                                } else {
                                  showDialog(
                                      context: ctx,
                                      builder: (conten) {
                                        return AlertDialog(
                                          content: Text(mssg),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isTvShowAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text(WATCHLIST),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tvShowDetail.tvGenres),
                            ),
                            // Text(
                            //   _showDuration(tv.runtime),
                            // ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvShowDetail.tv_show_voteAvg / 2,
                                  itemCount: 5,
                                  itemBuilder: (cntxt, idx) => Icon(
                                    Icons.star,
                                    color: pMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvShowDetail.tv_show_voteAvg}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              OVERVIEW,
                              style: pHeading6,
                            ),
                            Text(
                              tvShowDetail.tvShowOverview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              RECOMEN,
                              style: pHeading6,
                            ),
                            Consumer<TVShowDetailNotifier>(
                              builder: (cntxt, dt, chld) {
                                if (dt.tvShowRecommendationState ==
                                    EnumStateRequest.DataLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (dt.tvShowRecommendationState ==
                                    EnumStateRequest.DataError) {
                                  return Text(dt.mssg);
                                } else if (dt.tvShowRecommendationState ==
                                    EnumStateRequest.DataLoaded) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (cont, idx) {
                                        final tv = tvShowRecommendations[idx];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                cont,
                                                TVShowDetailPage.NAME_ROUTE,
                                                arguments: tv.idTv,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '$URL_BASE_IMAGE${tv.path_poster}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (contxt, urlErr, err) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: tvShowRecommendations.length,
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

}
