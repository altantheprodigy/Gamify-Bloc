import 'package:flutter/material.dart';
import 'package:gamifiy_bloc/utils/app_responsive.dart';
import 'package:gamifiy_bloc/utils/color.dart';
import 'package:gamifiy_bloc/utils/common_appbar.dart';
import 'package:gamifiy_bloc/utils/extension.dart';
import 'package:gamifiy_bloc/utils/text_style.dart';

class DetailPageView extends StatelessWidget {
  const DetailPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
          title: "Detail Page",
          route: () {
            // Get.back();
          },
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
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
                            "RockStar",
                            style: AppTextStyle()
                                .descriptionBold(context, AppColors.background),
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
                      "GTA San Andreas",
                      style:
                          AppTextStyle().title(context, AppColors.background),
                    ),
                    Text(
                      "${DateTime.now()}",
                      style: AppTextStyle()
                          .descriptionBold(context, AppColors.background),
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
                          "10",
                          style: AppTextStyle()
                              .descriptionBold(context, AppColors.background),
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
                              "100 Owned",
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
                      "Minimum:OS: Windows 10 64 Bit, Windows 8.1 64 Bit, Windows 8 64 Bit, Windows 7 64 Bit Service Pack 1, Windows Vista 64 Bit Service Pack 2* (*NVIDIA video card recommended if running Vista OS)Processor: Intel Core 2 Quad CPU Q6600 @ 2.40GHz (4 CPUs) / AMD Phenom 9850 Quad-Core Processor (4 CPUs) @ 2.5GHzMemory: 4 GB RAMGraphics: NVIDIA 9800 GT 1GB / AMD HD 4870 1GB (DX 10, 10.1, 11)Storage: 72 GB available spaceSound Card: 100% DirectX 10 compatibleAdditional Notes: Over time downloadable content and programming changes will change the system requirements for this game.  Please refer to your hardware manufacturer and www.rockstargames.com/support for current compatibility information. Some system components such as mobile chipsets, integrated, and AGP graphics cards may be incompatible. Unlisted specifications may not be supported by publisher.",
                      style: AppTextStyle()
                          .descriptionBold(context, AppColors.background),
                    ),
                  ],
                ),
              )
            ].withSpaceBetween(height: 10),
          ),
        ));
  }
}
