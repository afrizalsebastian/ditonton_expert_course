import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetTvSeriesDetail {
  final TvSeriesRespositories repository;

  GetTvSeriesDetail(this.repository);

  Future<Either<Failure, TvSeriresDetail>> execute(int id) {
    return repository.getTvSeriesDetail(id);
  }
}
