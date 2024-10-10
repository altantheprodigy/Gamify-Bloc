import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamifiy_bloc/pages/FavoritePage/Widgets/favorite_card.dart';
import 'package:gamifiy_bloc/pages/FavoritePage/bloc/favorite_bloc.dart';
import 'package:gamifiy_bloc/utils/color.dart';
import 'package:gamifiy_bloc/utils/common_appbar.dart';

class FavoritePageView extends StatelessWidget {
  const FavoritePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc()..add(LoadFavorites()),
      child: Scaffold(
        appBar: CommonAppBar(
          title: "Favorite Page",
          route: () {
            Navigator.pop(context);
          },
        ),
        body: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            print(state);
            if (state is FavoriteLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.hargaStat,
                ),
              );
            } else if (state is FavoriteLoaded) {
              if (state.favorites.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.favorite_rounded,
                        color: Colors.red,
                        size: 72,
                      ),
                      Text(
                        'No Favorite Item',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: ListView.builder(
                  itemCount: state.favorites.length,
                  itemBuilder: (context, index) {
                    final game = state.favorites[index];
                    return FavoriteCard(
                      id: game.id,
                      gameName: game.title,
                      releaseDate: DateTime.parse(game.released),
                      imagePath: game.image,
                      rating: game.rating,
                    );
                  },
                ),
              );
            } else if (state is FavoriteError) {
              return Center(child: Text(state.eror.toString()));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
