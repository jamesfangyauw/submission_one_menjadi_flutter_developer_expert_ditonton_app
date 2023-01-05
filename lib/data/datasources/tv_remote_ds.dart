import 'dart:convert';

import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_tv_show_detail.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/response_tv_show.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/excepDb.dart';
import 'package:http/http.dart' as http;

import '../../common/URL_BASE.dart';

abstract class TVRemoteDS {
  Future<List<ModelTVShow>> getTVShowRecommendations(int idTv);
  Future<List<ModelTVShow>> getNowPlayingTVShow();
  Future<List<ModelTVShow>> searchTVShow(String querydb);
  Future<List<ModelTVShow>> getTopRatedTVShow();
  Future<List<ModelTVShow>> getPopularTVShow();
  Future<ModelTVShowDetailResponse> getTVShowDetail(int idTv);
}

class TVShowRemoteDSImpl implements TVRemoteDS {
  final http.Client clientHTTP;

  TVShowRemoteDSImpl({required this.clientHTTP});

  @override
  Future<List<ModelTVShow>> getNowPlayingTVShow() async {
    final theresponse =
        await clientHTTP.get(Uri.parse('$URL_BASE/tv/on_the_air?$KEY_API'));
    return checkResponse(theresponse);
  }

  Future<List<ModelTVShow>> getTVShowRecommendations(int idTv) async {
    final theresponse = await clientHTTP
        .get(Uri.parse('$URL_BASE/tv/$idTv/recommendations?$KEY_API'));
    return checkResponse(theresponse);
  }

  Future<List<ModelTVShow>> searchTVShow(String querydb) async {
    final theresponse = await clientHTTP
        .get(Uri.parse('$URL_BASE/search/tv?$KEY_API&query=$querydb'));
    return checkResponse(theresponse);
  }

  Future<List<ModelTVShow>> getPopularTVShow() async {
    final theresponse =
        await clientHTTP.get(Uri.parse('$URL_BASE/tv/popular?$KEY_API'));
    return checkResponse(theresponse);
  }

  Future<ModelTVShowDetailResponse> getTVShowDetail(int idTv) async {
    final theresponse =
    await clientHTTP.get(Uri.parse('$URL_BASE/tv/$idTv?$KEY_API'));
    return showDetailRespon(theresponse);
  }

  Future<List<ModelTVShow>> getTopRatedTVShow() async {
    final theresponse =
        await clientHTTP.get(Uri.parse('$URL_BASE/tv/top_rated?$KEY_API'));
    return checkResponse(theresponse);
  }

  List<ModelTVShow> checkResponse(theresponse){
    if (theresponse.statusCode == 200) {
      return ResponseTVShow.fromJson(json.decode(theresponse.body)).tvShowList;
    } else {
      throw ExceptServer();
    }
  }
  ModelTVShowDetailResponse showDetailRespon(theresponse){
    if (theresponse.statusCode == 200) {
      return ModelTVShowDetailResponse.fromJson(json.decode(theresponse.body));
    } else {
      throw ExceptServer();
    }
  }
}
