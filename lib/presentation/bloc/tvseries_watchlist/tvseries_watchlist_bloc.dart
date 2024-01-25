import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tvseries_watchlist_state.dart';
part 'tvseries_watchlistevent.dart';

class TvSeriesWatchlistBloc
    extends Bloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState> {
  final GetWatchlistTvSeries _getTvSeriesWatchlist;

  TvSeriesWatchlistBloc(this._getTvSeriesWatchlist)
      : super(TvSeriesWatchlistEmpty()) {
    on<FetchTvSeriesWatchlist>((_, emit) async {
      emit(TvSeriesWatchlistLoading());

      final result = await _getTvSeriesWatchlist.execute();

      result.fold((failure) {
        emit(TvSeriesWatchlistError(failure.message));
      }, (data) {
        emit(TvSeriesWatchlistHasData(data));
      });
    });
  }
}
