import 'package:flutter/material.dart';
import 'package:gamifiy_bloc/pages/FavoritePage/favorite_page_view.dart';
import 'package:gamifiy_bloc/pages/HomePage/Widgets/home_card.dart';
import 'package:gamifiy_bloc/utils/color.dart';
import 'package:gamifiy_bloc/utils/extension.dart';
import 'package:gamifiy_bloc/utils/text_style.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        elevation: null,
        title: Text(
          "Games For You",
          style: AppTextStyle().descriptionBold(context, AppColors.fontAppBar),
        ),
        centerTitle: true,
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritePageView()),
            );
            // Get.toNamed("/favorit-page");
          },
          child: Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(64),
            ),
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(),
                    style: AppTextStyle()
                        .descriptionBold(context, AppColors.cardIconFill),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.background,
                      hintText: 'Cari Game...',
                      hintStyle: AppTextStyle()
                          .descriptionBold(context, AppColors.cardIconFill),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.background,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.search,
                      size: 20,
                      color: AppColors.cardIconFill,
                    ),
                  ),
                )
              ].withSpaceBetween(width: 10),
            ),
            Expanded(
              child: ListView.builder(
                // controller: controller.scrollController,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  // final game = controller.listGame[index];
                  return HomePageCard(
                    id: 1,
                    gameName: "GTA San Andress",
                    releaseDate: DateTime.now(),
                    imagePath:
                        "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
                    rating: 10,
                  );
                },
              ),
            )
          ].withSpaceBetween(height: 10),
        ),
      ),
    );
  }
}
