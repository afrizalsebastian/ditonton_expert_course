import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/search_tvseries.dart';
import 'package:ditonton/presentation/bloc/event_transformer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tvseries_search_event.dart';
part 'tvseries_search_state.dart';

class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchTvSeries _searchTvSeries;

  SearchTvSeriesBloc(this._searchTvSeries) : super(SearchTvSeriesEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchTvSeriesLoading());
      final result = await _searchTvSeries.execute(query);
      result.fold((failure) {
        emit(SearchTvSeriesError(failure.message));
      }, (data) {
        emit(SearchTvSeriesHasData(data));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
