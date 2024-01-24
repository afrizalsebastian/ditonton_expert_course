import 'package:ditonton/domain/usecases/tvseries/get_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusTvSeries usecase;
  late MockTvSeriesRespositories mockTvSeriesRespositories;

  setUp(() {
    mockTvSeriesRespositories = MockTvSeriesRespositories();
    usecase = GetWatchListStatusTvSeries(mockTvSeriesRespositories);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTvSeriesRespositories.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
