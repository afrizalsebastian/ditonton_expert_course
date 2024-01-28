import 'package:ditonton/data/models/tvseries_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';

final testTvSeries = TvSeries(
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

final testTvSeriesList = [testTvSeries];

const testTvSeriesDetail = TvSeriesDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [
    Genre(id: 18, name: 'Drama'),
    Genre(id: 80, name: 'Crime'),
  ],
  id: 1396,
  originalName: 'Breaking Bad',
  inProduction: false,
  numberOfEpisodes: 62,
  numberOfSeasons: 5,
  tagline: 'Change the equation',
  overview:
      "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
  posterPath: '/9faGSFi5jam6pDWGNd0p8JcJgXQ.jpg',
  firstAirDate: '2008-01-20',
  episodeRunTime: [],
  name: 'Breaking Bad',
  voteAverage: 8.898,
  voteCount: 12978,
);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1396,
  name: 'Breaking Bad',
  posterPath: '/9faGSFi5jam6pDWGNd0p8JcJgXQ.jpg',
  overview:
      "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
);

const testTvSeriesTable = TvSeriesTable(
  id: 1396,
  name: 'Breaking Bad',
  posterPath: '/9faGSFi5jam6pDWGNd0p8JcJgXQ.jpg',
  overview:
      "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
);

final testTvSeriesMap = {
  'id': 1396,
  'overview':
      "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
  'posterPath': '/9faGSFi5jam6pDWGNd0p8JcJgXQ.jpg',
  'name': 'Breaking Bad',
};
