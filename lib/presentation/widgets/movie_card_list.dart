import 'package:cached_network_image/cached_network_image.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/URL_BASE.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/all_movie_detail_page.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final Movie themovie;

  MovieCard(this.themovie);

  @override
  Widget build(BuildContext ctx) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            ctx,
            AllMovieDetailPage.NAME_ROUTE,
            arguments: themovie.idMovie,
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      themovie.titleMovie ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: pHeading6,
                    ),
                    SizedBox(height: 16),
                    Text(
                      themovie.overviewMovie ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: '$URL_BASE_IMAGE${themovie.posterPathMovie}',
                  width: 80,
                  placeholder: (cntnt, movieurl) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (cntx, urlBase, err) => Icon(Icons.error),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
