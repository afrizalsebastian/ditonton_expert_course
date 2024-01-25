part of 'tvseries_watchlist_bloc.dart';

abstract class TvSeriesWatchlistEvent extends Equatable {
  const TvSeriesWatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchTvSeriesWatchlist extends TvSeriesWatchlistEvent {}
