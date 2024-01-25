import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_now_playing_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'airing_today_tvseries_event.dart';
part 'airing_today_tvseries_state.dart';

class AiringTodayTvSeriesBloc
    extends Bloc<AiringTodayTvSeriesEvent, AiringTodayTvSeriesState> {
  final GetNowPlayingTvSeries _getAiringTodayTvSeries;

  AiringTodayTvSeriesBloc(this._getAiringTodayTvSeries)
      : super(AiringTodayTvSeriesEmpty()) {
    on<FetchAiringTodayTvSeries>((_, emit) async {
      emit(AiringTodayTvSeriesLoading());

      final result = await _getAiringTodayTvSeries.execute();

      result.fold((failure) {
        emit(AiringTodayTvSeriesError(failure.message));
      }, (data) {
        emit(AiringTodayTvSeriesHasData(data));
      });
    });
  }
}
