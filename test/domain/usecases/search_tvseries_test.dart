import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/search_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvSeriesRespositories mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRespositories();
    usecase = SearchTvSeries(mockTvSeriesRepository);
  });

  final tTvSeriess = <TvSeries>[];
  const tQuery = 'arcane';

  test('should get list of TvSeriess from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.searchTvSeries(tQuery))
        .thenAnswer((_) async => Right(tTvSeriess));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvSeriess));
  });
}
