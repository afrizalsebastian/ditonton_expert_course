import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(PopularMoviesEmpty()) {
    on<FetchPopularMovies>((_, emit) async {
      emit(PopularMoviesLoading());

      final result = await _getPopularMovies.execute();

      result.fold((failure) {
        emit(PopularMoviesError(failure.message));
      }, (data) {
        emit(PopularMoviesHasData(data));
      });
    });
  }
}
