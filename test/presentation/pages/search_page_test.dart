import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movies_search/search_bloc.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

void main() {
  late MockSearchBloc mockBloc;

  setUp(() {
    mockBloc = MockSearchBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display movies when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('should display text with search result when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchHasData(<Movie>[]));

    final textFinder = find.text('Search Result');

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('should display empty container when no data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchEmpty());

    final containerFinder = find.byType(Container);

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(containerFinder, findsOneWidget);
  });

  testWidgets('should display text with message when error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchError('Error Message'));
    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(textFinder, findsOneWidget);
  });
}
