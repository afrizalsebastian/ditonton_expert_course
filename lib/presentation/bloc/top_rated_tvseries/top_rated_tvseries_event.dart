part of 'top_rated_tvseries_bloc.dart';

abstract class TopRatedTvSeriesEvent extends Equatable {
  const TopRatedTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class FetchTopRatedTvSeries extends TopRatedTvSeriesEvent {}
