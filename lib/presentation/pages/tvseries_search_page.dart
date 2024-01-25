import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/tvseries_search/tvseries_search_bloc.dart';
import 'package:ditonton/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPageTvSeries extends StatelessWidget {
  static const ROUTE_NAME = '/search-tvseries';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchTvSeriesBloc>().add(OnQueryChanged(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchTvSeriesBloc, SearchTvSeriesState>(
                builder: (context, state) {
              if (state is SearchTvSeriesLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchTvSeriesHasData) {
                final result = state.result;
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final movie = result[index];
                      return TvSeriesCard(movie);
                    },
                    itemCount: result.length,
                  ),
                );
              } else if (state is SearchTvSeriesError) {
                return Expanded(
                  child: Center(
                    child: Text(state.message),
                  ),
                );
              } else {
                return Expanded(
                  child: Container(),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
