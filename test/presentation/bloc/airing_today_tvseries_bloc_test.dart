import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_now_playing_tvseries.dart';
import 'package:ditonton/presentation/bloc/airing_today_tvseries/airing_today_tvseries_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'airing_today_tvseries_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late AiringTodayTvSeriesBloc piringTodayTvSeriesBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    piringTodayTvSeriesBloc =
        AiringTodayTvSeriesBloc(mockGetNowPlayingTvSeries);
  });

  test('initital state should be empty', () {
    expect(piringTodayTvSeriesBloc.state, AiringTodayTvSeriesEmpty());
  });

  final tTvSeriesModel = TvSeries(
    adult: false,
    backdropPath: '/9faGSFi5jam6pDWGNd0p8JcJgXQ.jpg',
    genreIds: [18, 80],
    id: 1396,
    originalName: 'Breaking Bad',
    overview:
        "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
    popularity: 516.738,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2008-01-20',
    name: 'Breaking Bad',
    originCountry: ["US"],
    voteAverage: 8.898,
    voteCount: 12979,
  );
  final tTvSeriesList = <TvSeries>[tTvSeriesModel];

  blocTest<AiringTodayTvSeriesBloc, AiringTodayTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return piringTodayTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchAiringTodayTvSeries()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      AiringTodayTvSeriesLoading(),
      AiringTodayTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvSeries.execute());
    },
  );

  blocTest<AiringTodayTvSeriesBloc, AiringTodayTvSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return piringTodayTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchAiringTodayTvSeries()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      AiringTodayTvSeriesLoading(),
      AiringTodayTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvSeries.execute());
    },
  );
}
