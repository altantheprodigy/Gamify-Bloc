import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamifiy_bloc/pages/SearchPage/DataSource/remote_data_source.dart';
import 'package:gamifiy_bloc/pages/SearchPage/Widgets/search_widget_card.dart';
import 'package:gamifiy_bloc/pages/SearchPage/bloc/search_bloc.dart';
import 'package:gamifiy_bloc/utils/color.dart';
import 'package:gamifiy_bloc/utils/common_appbar.dart';
import 'package:gamifiy_bloc/utils/extension.dart';
import 'package:gamifiy_bloc/utils/text_style.dart';

class SearchPageView extends StatelessWidget {
  final String query;

  const SearchPageView({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchBloc(remoteDataSearchSource: RemoteDataSearchSource(), query)
            ..add(LoadSearchGame()),
      child: Scaffold(
        appBar: CommonAppBar(
          title: "Search Page",
          route: () {
            // Get.back();
          },
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.hargaStat,
                  ));
            } else if (state is SearchLoaded) {
              final data = state.searchGames.results;
              return Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        // controller: controller.scrollController,
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          // final game = controller.listGame[index];
                          final game = data[index];
                          return SearchPageCard(
                            id: game.id ?? 3498,
                            gameName: game.name ?? "Game Kosong",
                            releaseDate: game.released ?? DateTime.now(),
                            imagePath: game.backgroundImage ?? "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
                            rating: game.rating ?? 0,
                          );
                        },
                      ),
                    )
                  ].withSpaceBetween(height: 10),
                ),
              );
            } else if (state is SearchEror) {
              return Center(
                child: Text(state.message),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
