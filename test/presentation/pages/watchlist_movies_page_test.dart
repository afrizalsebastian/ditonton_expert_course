import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieWatchlistBloc
    extends MockBloc<MovieWatchlistEvent, MovieWatchlistState>
    implements MovieWatchlistBloc {}

void main() {
  late MockMovieWatchlistBloc mockBloc;

  setUp(() {
    mockBloc = MockMovieWatchlistBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieWatchlistBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieWatchlistLoading());

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display text error', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieWatchlistError('Error message'));

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(find.byKey(const Key('error_message')), findsOneWidget);
  });

  testWidgets('Page should display list view when data loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieWatchlistHasData(const <Movie>[]));

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(find.byType(ListView), findsOneWidget);
  });
}
