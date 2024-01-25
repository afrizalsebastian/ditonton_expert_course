import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tvseries_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tvseries_detail_event.dart';
part 'tvseries_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail _getTvSeriesDetail;

  TvSeriesDetailBloc(this._getTvSeriesDetail) : super(TvSeriesDetailEmpty()) {
    on<FetchTvSeriesDetail>((event, emit) async {
      final id = event.id;
      emit(TvSeriesDetailLoading());

      final result = await _getTvSeriesDetail.execute(id);

      result.fold((failure) {
        emit(TvSeriesDetailError(failure.message));
      }, (data) {
        emit(TvSeriesDetailHasData(data));
      });
    });
  }
}
