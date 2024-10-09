import 'package:flutter/material.dart';
import 'package:gamifiy_bloc/pages/FavoritePage/Widgets/favorite_card.dart';
import 'package:gamifiy_bloc/utils/common_appbar.dart';

class FavoritePageView extends StatelessWidget {
  const FavoritePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
            title: "Favorite Page",
            route: () {
              // Get.back();
            }),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              // final game = favoritePageController.favorites[index];
              return FavoriteCard(
                id: 1,
                gameName: "GTA San Andreas",
                releaseDate: DateTime.now(),
                imagePath: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
                rating: "1",
              );
            },
          ),
        )
    );
  }
}