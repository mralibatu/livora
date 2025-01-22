import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/routes/pages.dart';
import 'package:livora/screens/widgets/snake_light_effect_icon.dart';
import 'package:livora/utils/themes/app_sizes.dart';

Padding crackDailyWordNavigator() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let's Crack Your",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: AppSizes.h1,
                ),
              ),
              Text(
                "\t\t Daily Word",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: AppSizes.h0,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => {
              Get.toNamed(
                Pages.breakDailyWord,
              ),
            },
            child: SnakeSlideLightEffect(
              icon: Icons.arrow_forward_ios,
              size: AppSizes.h0 * 3,
            ),
          ),
        ],
      ),
    ),
  );
}
