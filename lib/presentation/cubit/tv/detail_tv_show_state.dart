part of 'detail_tv_show_cubit.dart';

class DetailTVShowState extends Equatable {
  final TVShowDetail tvShowDetail;
  final bool addWathclistIs;
  final String mssg;
  final String mssgWatchlist;
  final EnumStateRequest enumStateRequest;

  const DetailTVShowState({
    this.tvShowDetail = const TVShowDetail(),
    this.addWathclistIs = false,
    this.mssg = '',
    this.mssgWatchlist = '',
    this.enumStateRequest = EnumStateRequest.DataEmpty,
  });

  DetailTVShowState setTVShow(TVShowDetail tvShowDetail) => copyWith(tvShowDetail: tvShowDetail);
  DetailTVShowState setAddTVShowToWatchlist(bool valTVShow) => copyWith(isAddTVShowToWatchlist: valTVShow);
  DetailTVShowState setEnumStateRequest(EnumStateRequest enumStateRequest) =>
      copyWith(enumStateRequest: enumStateRequest);
  DetailTVShowState setMssg(String mssg) => copyWith(mssg: mssg);
  DetailTVShowState setMssgWatchlist(String mssg) => copyWith(mssgWatchlist: mssg);

  @override
  List<Object> get props {
    return [
      tvShowDetail,
      addWathclistIs,
      mssg,
      mssgWatchlist,
      enumStateRequest,
    ];
  }

  @override
  bool get strfy => true;

  DetailTVShowState copyWith({
    TVShowDetail? tvShowDetail,
    bool? isAddTVShowToWatchlist,
    String? mssg,
    String? mssgWatchlist,
    EnumStateRequest? enumStateRequest,
  }) {
    return DetailTVShowState(
      tvShowDetail: tvShowDetail ?? this.tvShowDetail,
      addWathclistIs: isAddTVShowToWatchlist ?? this.addWathclistIs,
      mssg: mssg ?? this.mssg,
      mssgWatchlist: mssgWatchlist ?? this.mssgWatchlist,
      enumStateRequest: enumStateRequest ?? this.enumStateRequest,
    );
  }
}
