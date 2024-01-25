part of 'movie_detail_watchlist_bloc.dart';

abstract class MovieDetailWatchlistState extends Equatable {
  const MovieDetailWatchlistState();

  @override
  List<Object> get props => [];
}

class InWatchlist extends MovieDetailWatchlistState {
  final String message;

  InWatchlist(this.message);

  @override
  List<Object> get props => [message];
}

class NotInWatchlist extends MovieDetailWatchlistState {
  final String message;

  NotInWatchlist(this.message);

  @override
  List<Object> get props => [message];
}
