import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/movies/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movies/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movies/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_detail_watchlist_event.dart';
part 'movie_detail_watchlist_state.dart';

class MovieDetailWatchlistBloc
    extends Bloc<MovieDetailWatchlistEvent, MovieDetailWatchlistState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailWatchlistBloc({
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(NotInWatchlist('')) {
    on<LoadWatchlistDetail>((event, emit) async {
      final id = event.id;

      final result = await getWatchListStatus.execute(id);
      if (result) {
        emit(InWatchlist(''));
      } else {
        emit(NotInWatchlist(''));
      }
    });

    on<AddWatchlistDetail>((event, emit) async {
      final movieDetail = event.movie;

      final result = await saveWatchlist.execute(movieDetail);

      await result.fold(
        (failure) async {
          emit(NotInWatchlist(failure.message));
        },
        (successMessage) async {
          emit(InWatchlist(successMessage));
        },
      );
    });

    on<RemoveWatchlistDetail>((event, emit) async {
      final movieDetail = event.movie;

      final result = await removeWatchlist.execute(movieDetail);

      await result.fold(
        (failure) async {
          emit(InWatchlist(failure.message));
        },
        (successMessage) async {
          emit(NotInWatchlist(successMessage));
        },
      );
    });
  }
}
