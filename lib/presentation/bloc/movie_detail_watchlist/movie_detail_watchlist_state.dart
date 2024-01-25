part of 'movie_detail_watchlist_bloc.dart';

abstract class MovieDetailWatchlistState extends Equatable {
  const MovieDetailWatchlistState(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class InWatchlist extends MovieDetailWatchlistState {
  final String message;

  InWatchlist(this.message) : super(message);

  @override
  List<Object> get props => [message];
}

class NotInWatchlist extends MovieDetailWatchlistState {
  final String message;

  NotInWatchlist(this.message) : super(message);

  @override
  List<Object> get props => [message];
}

class FailureWatchlist extends MovieDetailWatchlistState {
  final String message;

  FailureWatchlist(this.message) : super(message);

  @override
  List<Object> get props => [message];
}
