import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tvseries_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_tvseries_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail usecase;
  late MockTvSeriesRespositories mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRespositories();
    usecase = GetTvSeriesDetail(mockTvSeriesRepository);
  });

  final tId = 1396;

  test('should get tv series detail from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesDetail(tId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvSeriesDetail));
  });
}
