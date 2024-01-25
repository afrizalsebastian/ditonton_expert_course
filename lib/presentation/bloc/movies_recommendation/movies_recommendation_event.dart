part of 'movies_recommendation_bloc.dart';

abstract class MoviesRecommendationEvent extends Equatable {
  const MoviesRecommendationEvent();

  @override
  List<Object> get props => [];
}

class FetchMoviesRecommendation extends MoviesRecommendationEvent {
  final int id;

  FetchMoviesRecommendation(this.id);

  @override
  List<Object> get props => [id];
}
