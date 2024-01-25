import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/search_movies.dart';
import 'package:ditonton/presentation/bloc/event_transformer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;

  SearchBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      print(query);

      emit(SearchLoading());
      final result = await _searchMovies.execute(query);
      result.fold((failure) {
        emit(SearchError(failure.message));
      }, (data) {
        emit(SearchHasData(data));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
