import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamifiy_bloc/model/favorites_model.dart';
import 'package:gamifiy_bloc/pages/DetailPage/DataSource/remote_detail_game.dart';
import 'package:gamifiy_bloc/pages/DetailPage/bloc/detail_bloc.dart';
import 'package:gamifiy_bloc/pages/FavoritePage/bloc/favorite_bloc.dart'; // Import FavoriteBloc
import 'package:gamifiy_bloc/utils/app_responsive.dart';
import 'package:gamifiy_bloc/utils/color.dart';
import 'package:gamifiy_bloc/utils/common_appbar.dart';
import 'package:gamifiy_bloc/utils/extension.dart';
import 'package:gamifiy_bloc/utils/text_style.dart';
import 'package:intl/intl.dart';

class DetailPageView extends StatelessWidget {
  final int idGame;
  const DetailPageView({super.key, required this.idGame});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DetailBloc(
              remoteDetailDataSource: RemoteDetailDataSource(), gameId: idGame)
            ..add(LoadDetail()),
        ),
        BlocProvider(
          create: (context) => FavoriteBloc()..add(LoadFavorites()),
        ),
      ],
      child: Scaffold(
        appBar: CommonAppBar(
          title: "Detail Page",
          route: () {
            // Navigate back
          },
        ),
        body: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, detailState) {
            if (detailState is DetailLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.hargaStat,
                ),
              );
            } else if (detailState is DetailLoaded) {
              final detailGames = detailState.detailGames;

              return BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, favoriteState) {
                  if (favoriteState is FavoriteLoaded) {
                    final isFavorite = favoriteState.favorites
                        .any((fav) => fav.id == detailGames.id);

                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            detailGames.backgroundImage,
                            fit: BoxFit.cover,
                            height:
                                AppResponsive().screenWidth(context) * 0.850,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        detailGames.developers
                                            .map((developer) => developer.name)
                                            .join(", "),
                                        style: AppTextStyle().descriptionBold(
                                            context, AppColors.background),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (isFavorite) {
                                          context.read<FavoriteBloc>().add(
                                                RemoveFavorite(
                                                  Favorite(
                                                    id: detailGames.id,
                                                    title: detailGames.name,
                                                    image: detailGames
                                                        .backgroundImage,
                                                    rating: detailGames.rating
                                                        .toString(),
                                                    released: detailGames
                                                        .released
                                                        .toIso8601String(),
                                                  ),
                                                ),
                                              );
                                        } else {
                                          context.read<FavoriteBloc>().add(
                                                AddFavorites(
                                                  Favorite(
                                                    id: detailGames.id,
                                                    title: detailGames.name,
                                                    image: detailGames
                                                        .backgroundImage,
                                                    rating: detailGames.rating
                                                        .toString(),
                                                    released: detailGames
                                                        .released
                                                        .toIso8601String(),
                                                  ),
                                                ),
                                              );
                                        }
                                      },
                                      icon: Icon(
                                        Icons.favorite_rounded,
                                        color: isFavorite
                                            ? Colors.red
                                            : Colors.grey,
                                        size: 20,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  detailGames.name,
                                  style: AppTextStyle()
                                      .title(context, AppColors.background),
                                ),
                                Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(detailGames.released),
                                  style: AppTextStyle().descriptionBold(
                                      context, AppColors.background),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 20,
                                      color: AppColors.bintang,
                                    ),
                                    Text(
                                      detailGames.rating.toString(),
                                      style: AppTextStyle().descriptionBold(
                                          context, AppColors.background),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.videogame_asset,
                                          size: 20,
                                          color: AppColors.background,
                                        ),
                                        Text(
                                          "${detailGames.addedByStatus.owned} Owned",
                                          style: AppTextStyle().descriptionBold(
                                              context, AppColors.background),
                                        ),
                                      ].withSpaceBetween(width: 5),
                                    )
                                  ].withSpaceBetween(width: 5),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  detailGames.description,
                                  style: AppTextStyle().descriptionBold(
                                      context, AppColors.background),
                                ),
                              ],
                            ),
                          )
                        ].withSpaceBetween(height: 10),
                      ),
                    );
                  } else if (favoriteState is FavoriteError) {
                    return Center(
                      child: Text(favoriteState.eror),
                    );
                  }
                  return const SizedBox();
                },
              );
            } else if (detailState is DetailEror) {
              return Center(
                child: Text(detailState.message),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
