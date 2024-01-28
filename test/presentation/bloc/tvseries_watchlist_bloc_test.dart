import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries_watchlist/tvseries_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvseries_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late TvSeriesWatchlistBloc tvSeriesWatchlistBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    tvSeriesWatchlistBloc = TvSeriesWatchlistBloc(mockGetWatchlistTvSeries);
  });

  test('initital state should be empty', () {
    expect(tvSeriesWatchlistBloc.state, TvSeriesWatchlistEmpty());
  });

  final tTvSeriesModel = TvSeries(
    adult: false,
    backdropPath: '/9faGSFi5jam6pDWGNd0p8JcJgXQ.jpg',
    genreIds: const [18, 80],
    id: 1396,
    originalName: 'Breaking Bad',
    overview:
        "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
    popularity: 516.738,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2008-01-20',
    name: 'Breaking Bad',
    originCountry: const ["US"],
    voteAverage: 8.898,
    voteCount: 12979,
  );
  final tTvSeriesList = <TvSeries>[tTvSeriesModel];

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return tvSeriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesWatchlist()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvSeriesWatchlistLoading(),
      TvSeriesWatchlistHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesWatchlist()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSeriesWatchlistLoading(),
      TvSeriesWatchlistError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );
}
