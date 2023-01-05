import 'package:flutter/widgets.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/genre_entities.dart';

import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/constants.dart';

final RouteObserver<ModalRoute> obsrvrRouteUtil = RouteObserver<ModalRoute>();

String GnrsGetFrmatted(List<GenreEntities> gnreEntities) {
  String strRslt = '';
  for (var genreEntities in gnreEntities) {
    strRslt += genreEntities.nameGenre + KOMA;
  }

  if (strRslt.isEmpty) {
    return strRslt;
  }

  return strRslt.substring(0, strRslt.length - 2);
}

String frmttdDurationGetFromListType(List<int> tmsRun) =>
    tmsRun.map((tmsrun) => getFormattedDuration(tmsrun)).join(KOMA);

String getFormattedDuration(int tmsRun) {
  final int totalHrs = tmsRun ~/ 60;
  final int totalMnts = tmsRun % 60;
  return convertion(totalHrs, totalMnts);
}

String convertion(totalHrs,totalMnts){
  if (totalHrs > 0) {
    return '${totalHrs}h ${totalMnts}m';
  } else {
    return '${totalMnts}m';
  }
}
