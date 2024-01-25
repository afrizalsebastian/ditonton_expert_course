import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_tvseries_event.dart';
part 'popular_tvseries_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries _getPopularTvSeries;

  PopularTvSeriesBloc(this._getPopularTvSeries)
      : super(PopularTvSeriesEmpty()) {
    on<FetchPopularTvSeries>((_, emit) async {
      emit(PopularTvSeriesLoading());

      final result = await _getPopularTvSeries.execute();

      result.fold((failure) {
        emit(PopularTvSeriesError(failure.message));
      }, (data) {
        emit(PopularTvSeriesHasData(data));
      });
    });
  }
}
