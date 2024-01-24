import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_now_playing_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvSeries usecase;
  late MockTvSeriesRespositories mockTvSeriesRespositories;

  setUp(() {
    mockTvSeriesRespositories = MockTvSeriesRespositories();
    usecase = GetNowPlayingTvSeries(mockTvSeriesRespositories);
  });

  final tvSeries = <TvSeries>[];

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRespositories.getNowPlayingTvSeries())
        .thenAnswer((_) async => Right(tvSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tvSeries));
  });
}
