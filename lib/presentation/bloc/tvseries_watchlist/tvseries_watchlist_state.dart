part of 'tvseries_watchlist_bloc.dart';

abstract class TvSeriesWatchlistState extends Equatable {
  const TvSeriesWatchlistState();

  @override
  List<Object> get props => [];
}

class TvSeriesWatchlistEmpty extends TvSeriesWatchlistState {}

class TvSeriesWatchlistLoading extends TvSeriesWatchlistState {}

class TvSeriesWatchlistError extends TvSeriesWatchlistState {
  final String message;

  TvSeriesWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesWatchlistHasData extends TvSeriesWatchlistState {
  final List<TvSeries> result;

  TvSeriesWatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}
