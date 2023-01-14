import 'package:bloc/bloc.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/utils.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/movie_entities.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/usecases/search_all_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'search_all_the_movies_event.dart';
part 'search_all_the_movies_state.dart';

@injectable
class SearchAllTheMoviesBloc extends Bloc<SearchAllTheMoviesEvent, SearchAllTheMoviesState> {
  SearchAllTheMoviesBloc(this.searchAllTheMovies) : super(SearchAllTheMoviesInitial()) {
    on<SearchAllTheMoviesAction>(
      (evt, emt) async {
        emt(SearchAllTheMoviesLoading());
        final theresult = await searchAllTheMovies.execute(evt.thequery);
        theresult.fold(
          (flr) => emt(SearchAllTheMoviesError(flr.mssg)),
          (dt) => emt(SearchAllTheMoviesLoaded(dt)),
        );
      },
      transformer: dbounce(const Duration(milliseconds: 300)),
    );
  }

  final SearchAllMovies searchAllTheMovies;
}
