import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetWatchListStatus {
  final TvSeriesRespositories repository;

  GetWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
