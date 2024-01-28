import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvseries/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_tvseries_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvSeries usecase;
  late MockTvSeriesRespositories mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRespositories();
    usecase = SaveWatchlistTvSeries(mockTvSeriesRepository);
  });

  test('should save TvSeries to the repository', () async {
    // arrange
    when(mockTvSeriesRepository.saveWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(mockTvSeriesRepository.saveWatchlist(testTvSeriesDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
