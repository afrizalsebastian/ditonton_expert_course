part of 'airing_today_tvseries_bloc.dart';

abstract class AiringTodayTvSeriesEvent extends Equatable {
  const AiringTodayTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class FetchAiringTodayTvSeries extends AiringTodayTvSeriesEvent {}
