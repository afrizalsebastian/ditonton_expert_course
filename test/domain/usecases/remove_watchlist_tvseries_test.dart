import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvseries/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_tvseries_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTvSeries usecase;
  late MockTvSeriesRespositories mockTvSeriesRespositories;

  setUp(() {
    mockTvSeriesRespositories = MockTvSeriesRespositories();
    usecase = RemoveWatchlistTvSeries(mockTvSeriesRespositories);
  });

  test('should remove watchlist tvseries from repository', () async {
    // arrange
    when(mockTvSeriesRespositories.removeWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(mockTvSeriesRespositories.removeWatchlist(testTvSeriesDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
