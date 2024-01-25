import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tvseries_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tvseries_recommendation_event.dart';
part 'tvseries_recommendation_state.dart';

class TvSeriesRecommendationBloc
    extends Bloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState> {
  final GetTvSeriesRecommendations _getTvSeriesRecommendation;

  TvSeriesRecommendationBloc(this._getTvSeriesRecommendation)
      : super(TvSeriesRecommendationEmpty()) {
    on<FetchTvSeriesRecommendation>((event, emit) async {
      final id = event.id;
      emit(TvSeriesRecommendationLoading());

      final result = await _getTvSeriesRecommendation.execute(id);

      result.fold((failure) {
        emit(TvSeriesRecommendationError(failure.message));
      }, (data) {
        emit(TvSeriesRecommendationHasData(data));
      });
    });
  }
}
