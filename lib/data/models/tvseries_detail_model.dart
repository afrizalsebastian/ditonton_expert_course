import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailResponse extends Equatable {
  const TvSeriesDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.inProduction,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.name,
    required this.tagline,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final List<int>? episodeRunTime;
  final String firstAirDate;
  final List<GenreModel> genres;
  final int id;
  final bool inProduction;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalName;
  final String overview;
  final String posterPath;
  final String name;
  final String? tagline;
  final double voteAverage;
  final int voteCount;

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        tagline: json["tagline"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: json['first_air_date'].toString(),
        inProduction: json['in_production'],
        name: json['name'],
        numberOfEpisodes: json['number_of_episodes'],
        numberOfSeasons: json['number_of_seasons'],
        originalName: json['original_name'],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "overview": overview,
        "poster_path": posterPath,
        "tagline": tagline,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "episode_run_time": List<int>.from(episodeRunTime?.map((x) => x) ?? []),
        'first_air_date': firstAirDate.toString(),
        'in_production': inProduction,
        'name': name,
        'number_of_episodes': numberOfEpisodes,
        'number_of_seasons': numberOfSeasons,
        'original_name': originalName,
      };

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      adult: adult,
      backdropPath: backdropPath,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      overview: overview,
      posterPath: posterPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
      episodeRunTime: List<int>.from(episodeRunTime?.map((x) => x) ?? []),
      firstAirDate: firstAirDate,
      inProduction: inProduction,
      name: name,
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      originalName: originalName,
      tagline: tagline,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        episodeRunTime,
        firstAirDate,
        genres,
        id,
        inProduction,
        numberOfEpisodes,
        numberOfSeasons,
        originalName,
        overview,
        posterPath,
        name,
        tagline,
        voteAverage,
        voteCount,
      ];
}
