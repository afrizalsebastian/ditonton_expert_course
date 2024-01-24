import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/presentation/pages/watchlist_tvseries_page.dart';
import 'package:ditonton/presentation/provider/watchlist_tvseries_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'watchlist_tvseries_page_test.mocks.dart';

@GenerateMocks([WatchlistTvSeriesNotifier])
void main() {
  late MockWatchlistTvSeriesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockWatchlistTvSeriesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<WatchlistTvSeriesNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress',
      (WidgetTester tester) async {
    when(mockNotifier.watchlistState).thenReturn(RequestState.Loading);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvSeriesPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display text error', (WidgetTester tester) async {
    when(mockNotifier.watchlistState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvSeriesPage()));

    expect(find.byKey(Key('error_message')), findsOneWidget);
  });

  testWidgets('Page should display list view when data loaded',
      (WidgetTester tester) async {
    when(mockNotifier.watchlistState).thenReturn(RequestState.Loaded);
    when(mockNotifier.watchlistTvSeries).thenReturn(<TvSeries>[]);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvSeriesPage()));

    expect(find.byType(ListView), findsOneWidget);
  });
}
