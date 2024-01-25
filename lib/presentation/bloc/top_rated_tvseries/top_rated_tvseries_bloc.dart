import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_tvseries_event.dart';
part 'top_rated_tvseries_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTvSeries _getTopRatedTvSeries;

  TopRatedTvSeriesBloc(this._getTopRatedTvSeries)
      : super(TopRatedTvSeriesEmpty()) {
    on<FetchTopRatedTvSeries>((_, emit) async {
      emit(TopRatedTvSeriesLoading());

      final result = await _getTopRatedTvSeries.execute();

      result.fold((failure) {
        emit(TopRatedTvSeriesError(failure.message));
      }, (data) {
        emit(TopRatedTvSeriesHasData(data));
      });
    });
  }
}
