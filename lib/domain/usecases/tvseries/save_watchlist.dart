import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class SaveWatchlistTvSeries {
  final TvSeriesRespositories repository;

  SaveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriresDetail tvSeries) {
    return repository.saveWatchlist(tvSeries);
  }
}
