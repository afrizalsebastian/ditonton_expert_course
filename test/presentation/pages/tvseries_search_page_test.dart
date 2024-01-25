import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries_search/tvseries_search_bloc.dart';
import 'package:ditonton/presentation/pages/tvseries_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchBloc extends MockBloc<SearchTvSeriesEvent, SearchTvSeriesState>
    implements SearchTvSeriesBloc {}

void main() {
  late MockSearchBloc mockBloc;

  setUp(() {
    mockBloc = MockSearchBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchTvSeriesBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display tvseries when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchTvSeriesHasData(<TvSeries>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(SearchPageTvSeries()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('should display text with search result when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchTvSeriesHasData(<TvSeries>[]));

    final textFinder = find.text('Search Result');

    await tester.pumpWidget(_makeTestableWidget(SearchPageTvSeries()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('should display empty container when no data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchTvSeriesEmpty());

    final containerFinder = find.byType(Container);

    await tester.pumpWidget(_makeTestableWidget(SearchPageTvSeries()));

    expect(containerFinder, findsOneWidget);
  });

  testWidgets('should display text with message when error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchTvSeriesError('message'));
    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(SearchPageTvSeries()));

    expect(textFinder, findsOneWidget);
  });
}
