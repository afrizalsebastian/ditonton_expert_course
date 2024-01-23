import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class RemoveWatchlistTvSeries {
  final TvSeriesRespositories repository;

  RemoveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriresDetail tvSeries) {
    return repository.removeWatchlist(tvSeries);
  }
}
