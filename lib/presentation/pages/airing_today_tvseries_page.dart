import 'package:ditonton/presentation/bloc/airing_today_tvseries/airing_today_tvseries_bloc.dart';
import 'package:ditonton/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiringTodayTvSeries extends StatefulWidget {
  static const ROUTE_NAME = '/airing-today-tvseries';

  const AiringTodayTvSeries({super.key});

  @override
  _AiringTodayTvSeriesState createState() => _AiringTodayTvSeriesState();
}

class _AiringTodayTvSeriesState extends State<AiringTodayTvSeries> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<AiringTodayTvSeriesBloc>()
        .add(FetchAiringTodayTvSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airing Today TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AiringTodayTvSeriesBloc, AiringTodayTvSeriesState>(
          builder: (context, state) {
            if (state is AiringTodayTvSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AiringTodayTvSeriesHasData) {
              final data = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data[index];
                  return TvSeriesCard(movie);
                },
                itemCount: data.length,
              );
            } else if (state is AiringTodayTvSeriesError) {
              return Text(state.message);
            } else {
              return const Text('Failed');
            }
          },
        ),
      ),
    );
  }
}
