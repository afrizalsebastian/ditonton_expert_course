import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movies_recommendation_event.dart';
part 'movies_recommendation_state.dart';

class MoviesRecommendationBloc
    extends Bloc<MoviesRecommendationEvent, MoviesRecommendationState> {
  final GetMovieRecommendations _getMoviesRecommendation;

  MoviesRecommendationBloc(this._getMoviesRecommendation)
      : super(MoviesRecommendationEmpty()) {
    on<FetchMoviesRecommendation>((event, emit) async {
      final id = event.id;
      emit(MoviesRecommendationLoading());

      final result = await _getMoviesRecommendation.execute(id);

      result.fold((failure) {
        emit(MoviesRecommendationError(failure.message));
      }, (data) {
        emit(MoviesRecommendationHasData(data));
      });
    });
  }
}
