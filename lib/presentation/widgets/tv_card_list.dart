import 'package:cached_network_image/cached_network_image.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/URL_BASE.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/presentation/pages/tv_show_detail_page.dart';
import 'package:flutter/material.dart';

class TVCard extends StatelessWidget {
  final TVEntities tvEntities;

  TVCard(this.tvEntities);

  @override
  Widget build(BuildContext cntx) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            cntx,
            TVShowDetailPage.NAME_ROUTE,
            arguments: tvEntities.idTv,
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
                      tvEntities.nameTv ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: pHeading6,
                    ),
                    SizedBox(height: 16),
                    Text(
                      tvEntities.tv_overview ?? '-',
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
                  imageUrl: '$URL_BASE_IMAGE${tvEntities.path_poster}',
                  width: 80,
                  placeholder: (ctx, urlTv) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (ctx, urlTv, err) => Icon(Icons.error),
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
