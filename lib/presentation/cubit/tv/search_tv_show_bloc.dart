import 'package:bloc/bloc.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/utils.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/tv_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/tv/search_all_tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
part 'search_tv_show_event.dart';
part 'search_tv_show_state.dart';
@injectable
class SearchTVShowBloc
    extends Bloc<SearchTVShowEvent, SearchTVShowState> {
  SearchTVShowBloc(this.searchAllTVShow) : super(SearchTVShowInitial()) {
    on<SearchTVShowAction>(
      (evt, emt) async {
        emt(SearchTVShowLoading());
        final theresult = await searchAllTVShow.execute(evt.thequery);
        theresult.fold(
          (flr) => emt(SearchTVShowError(flr.mssg)),
          (dt) => emt(SearchTVShowLoaded(dt)),
        );
      },
      transformer: dbounce(const Duration(milliseconds: 300)),
    );
  }
  final SearchAllTVShow searchAllTVShow;
}
