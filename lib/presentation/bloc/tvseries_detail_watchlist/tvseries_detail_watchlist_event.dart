part of 'tvseries_detail_watchlist_bloc.dart';

abstract class TvSeriesDetailWatchlistEvent extends Equatable {
  const TvSeriesDetailWatchlistEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlistDetail extends TvSeriesDetailWatchlistEvent {
  final TvSeriesDetail tvSeries;

  AddWatchlistDetail(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class RemoveWatchlistDetail extends TvSeriesDetailWatchlistEvent {
  final TvSeriesDetail tvSeries;

  RemoveWatchlistDetail(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class LoadWatchlistDetail extends TvSeriesDetailWatchlistEvent {
  final int id;

  LoadWatchlistDetail(this.id);

  @override
  List<Object> get props => [id];
}
