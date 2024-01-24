import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/presentation/pages/tvseries_search_page.dart';
import 'package:ditonton/presentation/provider/tvseries_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'tvseries_search_page_test.mocks.dart';

@GenerateMocks([TvSeriesSearchNotifier])
void main() {
  late MockTvSeriesSearchNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSeriesSearchNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSeriesSearchNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display tvseries when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.searchResult).thenReturn(<TvSeries>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(SearchPageTvSeries()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('should display text with search result when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.searchResult).thenReturn(<TvSeries>[]);

    final textFinder = find.text('Search Result');

    await tester.pumpWidget(_makeTestableWidget(SearchPageTvSeries()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('should display empty container when no data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Empty);

    final containerFinder = find.byType(Container);

    await tester.pumpWidget(_makeTestableWidget(SearchPageTvSeries()));

    expect(containerFinder, findsOneWidget);
  });

  testWidgets('should display text with message when error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    final containerFinder = find.byType(Container);

    await tester.pumpWidget(_makeTestableWidget(SearchPageTvSeries()));

    expect(containerFinder, findsOneWidget);
  });
}
