import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tvseries/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/tvseries/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tvseries_detail_watchlist_event.dart';
part 'tvseries_detail_watchlist_state.dart';

class TvSeriesDetailWatchlistBloc
    extends Bloc<TvSeriesDetailWatchlistEvent, TvSeriesDetailWatchlistState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchListStatusTvSeries getWatchListStatus;
  final SaveWatchlistTvSeries saveWatchlist;
  final RemoveWatchlistTvSeries removeWatchlist;

  TvSeriesDetailWatchlistBloc({
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
      final tvSeriesDetail = event.tvSeries;

      final result = await saveWatchlist.execute(tvSeriesDetail);

      result.fold(
        (failure) {
          emit(FailureWatchlist(failure.message));
        },
        (successMessage) {
          emit(InWatchlist(successMessage));
        },
      );
    });

    on<RemoveWatchlistDetail>((event, emit) async {
      final tvSeriesDetail = event.tvSeries;

      final result = await removeWatchlist.execute(tvSeriesDetail);

      result.fold(
        (failure) {
          emit(FailureWatchlist(failure.message));
        },
        (successMessage) {
          emit(NotInWatchlist(successMessage));
        },
      );
    });
  }
}
