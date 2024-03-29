part of 'tvseries_recommendation_bloc.dart';

abstract class TvSeriesRecommendationState extends Equatable {
  const TvSeriesRecommendationState();

  @override
  List<Object> get props => [];
}

class TvSeriesRecommendationEmpty extends TvSeriesRecommendationState {}

class TvSeriesRecommendationLoading extends TvSeriesRecommendationState {}

class TvSeriesRecommendationError extends TvSeriesRecommendationState {
  final String message;

  TvSeriesRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesRecommendationHasData extends TvSeriesRecommendationState {
  final List<TvSeries> result;

  TvSeriesRecommendationHasData(this.result);

  @override
  List<Object> get props => [result];
}
