part of 'tvseries_detail_watchlist_bloc.dart';

abstract class TvSeriesDetailWatchlistState extends Equatable {
  const TvSeriesDetailWatchlistState(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class InWatchlist extends TvSeriesDetailWatchlistState {
  final String message;

  InWatchlist(this.message) : super(message);

  @override
  List<Object> get props => [message];
}

class NotInWatchlist extends TvSeriesDetailWatchlistState {
  final String message;

  NotInWatchlist(this.message) : super(message);

  @override
  List<Object> get props => [message];
}

class FailureWatchlist extends TvSeriesDetailWatchlistState {
  final String message;

  FailureWatchlist(this.message) : super(message);

  @override
  List<Object> get props => [message];
}
