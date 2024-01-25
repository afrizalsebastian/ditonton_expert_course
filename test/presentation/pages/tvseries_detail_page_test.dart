import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries_detail/tvseries_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries_detail_watchlist/tvseries_detail_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries_recommendation/tvseries_recommendation_bloc.dart';
import 'package:ditonton/presentation/pages/tvseries_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_tvseries_object.dart';

class MockTvSeriesDetailBloc
    extends MockBloc<TvSeriesDetailEvent, TvSeriesDetailState>
    implements TvSeriesDetailBloc {}

class MockTvSeriesRecommendationBloc
    extends MockBloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState>
    implements TvSeriesRecommendationBloc {}

class MockTvSeriesDetailWatchlistBloc
    extends MockBloc<TvSeriesDetailWatchlistEvent, TvSeriesDetailWatchlistState>
    implements TvSeriesDetailWatchlistBloc {}

void main() {
  late MockTvSeriesDetailBloc mockTvSeriesDetailBloc;
  late MockTvSeriesRecommendationBloc mockTvSeriesRecommendationBloc;
  late MockTvSeriesDetailWatchlistBloc mockTvSeriesDetailWatchlistBloc;

  setUp(() {
    mockTvSeriesDetailBloc = MockTvSeriesDetailBloc();
    mockTvSeriesRecommendationBloc = MockTvSeriesRecommendationBloc();
    mockTvSeriesDetailWatchlistBloc = MockTvSeriesDetailWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<TvSeriesDetailBloc>.value(value: mockTvSeriesDetailBloc),
        BlocProvider<TvSeriesRecommendationBloc>.value(
            value: mockTvSeriesRecommendationBloc),
        BlocProvider<TvSeriesDetailWatchlistBloc>.value(
            value: mockTvSeriesDetailWatchlistBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv series not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(<TvSeries>[]));
    when(() => mockTvSeriesDetailWatchlistBloc.state)
        .thenReturn(NotInWatchlist(''));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1396)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv series is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(<TvSeries>[]));
    when(() => mockTvSeriesDetailWatchlistBloc.state)
        .thenReturn(InWatchlist(''));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1396)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(<TvSeries>[]));
    when(() => mockTvSeriesDetailWatchlistBloc.state)
        .thenReturn(NotInWatchlist(''));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1396)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(<TvSeries>[]));
    when(() => mockTvSeriesDetailWatchlistBloc.state)
        .thenReturn(FailureWatchlist('Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1396)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
