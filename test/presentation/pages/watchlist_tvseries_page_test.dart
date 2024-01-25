import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries_watchlist/tvseries_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_tvseries_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTvSeriesWatchlistBloc
    extends MockBloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState>
    implements TvSeriesWatchlistBloc {}

void main() {
  late MockTvSeriesWatchlistBloc mockBloc;

  setUp(() {
    mockBloc = MockTvSeriesWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesWatchlistBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvSeriesWatchlistLoading());

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvSeriesPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display text error', (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(TvSeriesWatchlistError('Error message'));
    await tester.pumpWidget(_makeTestableWidget(WatchlistTvSeriesPage()));

    expect(find.byKey(Key('error_message')), findsOneWidget);
  });

  testWidgets('Page should display list view when data loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(TvSeriesWatchlistHasData(<TvSeries>[]));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvSeriesPage()));

    expect(find.byType(ListView), findsOneWidget);
  });
}
