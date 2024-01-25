import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies)
      : super(NowPlayingMoviesEmpty()) {
    on<FetchNowPlayingMovies>((_, emit) async {
      emit(NowPlayingMoviesLoading());

      final result = await _getNowPlayingMovies.execute();

      result.fold((failure) {
        emit(NowPlayingMoviesError(failure.message));
      }, (data) {
        emit(NowPlayingMoviesHasData(data));
      });
    });
  }
}
