import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_detail_watchlist/movie_detail_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/movies_recommendation/movies_recommendation_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MockMoviesRecommendationBloc
    extends MockBloc<MoviesRecommendationEvent, MoviesRecommendationState>
    implements MoviesRecommendationBloc {}

class MockMovieDetailWatchlistBloc
    extends MockBloc<MovieDetailWatchlistEvent, MovieDetailWatchlistState>
    implements MovieDetailWatchlistBloc {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMoviesRecommendationBloc mockMoviesRecommendationBloc;
  late MockMovieDetailWatchlistBloc mockMovieDetailWatchlistBloc;

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMoviesRecommendationBloc = MockMoviesRecommendationBloc();
    mockMovieDetailWatchlistBloc = MockMovieDetailWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<MovieDetailBloc>.value(value: mockMovieDetailBloc),
        BlocProvider<MoviesRecommendationBloc>.value(
            value: mockMoviesRecommendationBloc),
        BlocProvider<MovieDetailWatchlistBloc>.value(
            value: mockMovieDetailWatchlistBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => mockMoviesRecommendationBloc.state)
        .thenReturn(MoviesRecommendationHasData(<Movie>[]));
    when(() => mockMovieDetailWatchlistBloc.state)
        .thenReturn(NotInWatchlist(''));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => mockMoviesRecommendationBloc.state)
        .thenReturn(MoviesRecommendationHasData(<Movie>[]));
    when(() => mockMovieDetailWatchlistBloc.state).thenReturn(InWatchlist(''));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => mockMoviesRecommendationBloc.state)
        .thenReturn(MoviesRecommendationHasData(<Movie>[]));
    when(() => mockMovieDetailWatchlistBloc.state)
        .thenReturn(NotInWatchlist(''));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => mockMoviesRecommendationBloc.state)
        .thenReturn(MoviesRecommendationHasData(<Movie>[]));
    when(() => mockMovieDetailWatchlistBloc.state)
        .thenReturn(FailureWatchlist('Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
