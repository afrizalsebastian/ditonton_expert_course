part of 'movie_detail_watchlist_bloc.dart';

abstract class MovieDetailWatchlistEvent extends Equatable {
  const MovieDetailWatchlistEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlistDetail extends MovieDetailWatchlistEvent {
  final MovieDetail movie;

  AddWatchlistDetail(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveWatchlistDetail extends MovieDetailWatchlistEvent {
  final MovieDetail movie;

  RemoveWatchlistDetail(this.movie);

  @override
  List<Object> get props => [movie];
}

class LoadWatchlistDetail extends MovieDetailWatchlistEvent {
  final int id;

  LoadWatchlistDetail(this.id);

  @override
  List<Object> get props => [id];
}
