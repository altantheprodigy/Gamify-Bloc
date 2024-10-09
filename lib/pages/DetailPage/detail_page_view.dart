import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamifiy_bloc/pages/DetailPage/DataSource/remote_detail_game.dart';
import 'package:gamifiy_bloc/pages/DetailPage/bloc/detail_bloc.dart';
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
    return BlocProvider(
      create: (context) => DetailBloc(
          remoteDetailDataSource: RemoteDetailDataSource(), gameId: idGame)
        ..add(LoadDetail()),
      child: Scaffold(
          appBar: CommonAppBar(
            title: "Detail Page",
            route: () {
              // Get.back();
            },
          ),
          body: BlocBuilder<DetailBloc, DetailState>(
            builder: (context, state) {
              if (state is DetailLoading) {
                return Center(
                    child: CircularProgressIndicator(
                  color: AppColors.hargaStat,
                ));
              } else if (state is DetailLoaded) {
                final detailGames = state.detailGames;
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        detailGames.backgroundImage,
                        fit: BoxFit.cover,
                        height: AppResponsive().screenWidth(context) * 0.850,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.favorite_rounded,
                                      color: AppColors.hargaStat,
                                      size: 20,
                                    ))
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
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
              } else if (state is DetailEror) {
                return Center(
                  child: Text(state.message),
                );
              }
              return SizedBox();
            },
          )),
    );
  }
}
