import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries usecase;
  late MockTvSeriesRespositories mockTvSeriesRpository;

  setUp(() {
    mockTvSeriesRpository = MockTvSeriesRespositories();
    usecase = GetPopularTvSeries(mockTvSeriesRpository);
  });

  final tvSeries = <TvSeries>[];

  group('GetPopularTvSeries Tests', () {
    group('execute', () {
      test(
          'should get list of tv series from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvSeriesRpository.getPopularTvSeries())
            .thenAnswer((_) async => Right(tvSeries));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tvSeries));
      });
    });
  });
}
