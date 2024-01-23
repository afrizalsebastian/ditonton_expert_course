import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetWatchListStatusTvSeries {
  final TvSeriesRespositories repository;

  GetWatchListStatusTvSeries(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
