import 'package:flutter/cupertino.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/models/model_tv_show.dart';
import 'package:equatable/equatable.dart';

class ResponseTVShow extends Equatable {
  final List<ModelTVShow> tvShowList;
  @immutable ResponseTVShow({required this.tvShowList});

  factory ResponseTVShow.fromJson(Map<String, dynamic> json) => ResponseTVShow(
        tvShowList: List<ModelTVShow>.from((json["results"] as List)
            .map((x) => ModelTVShow.fromJson(x))
            .where((element) => element.path_poster != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvShowList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [tvShowList];
}
