import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/color.dart';

class SheetScrollableContainer extends StatelessWidget {
  const SheetScrollableContainer({
    Key? keycontainer,
    required this.urlBg,
    required this.contentScroll,
  }) : super(key: keycontainer);

  final String urlBg;
  final List<Widget> contentScroll;

  @override
  Widget build(BuildContext cntx) {
    final widthScrn = MediaQuery.of(cntx).size.width;

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: urlBg,
          width: widthScrn,
          placeholder: (ctx, baseurl) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (ctx, baseurl, errmsg) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (contex, scrlcntroler) {
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
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrlcntroler,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: contentScroll,
                        ),
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
        ),
      ],
    );
  }
}
