import 'package:flutter/material.dart';
import 'package:livora/data/repositories/user_repository.dart';
import 'package:livora/screens/widgets/circle_avatar_with_icon.dart';
import 'package:livora/utils/themes/app_colors.dart';
import 'package:livora/utils/themes/app_sizes.dart';

Row HomeHeading() {
  UserRepository userRepository = UserRepository();
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CircleAwatarWithIcon(
          Image.asset("assets/images/working.png"), Icons.school),
      Row(
        children: [
          Row(
            children: [
              Icon(
                Icons.rocket_launch_outlined,
                size: AppSizes.h0,
                color: AppColors.multipleColor3,
              ),
              SizedBox(
                width: AppSizes.h3 / 2,
              ),
              FutureBuilder(
                future: userRepository.getStreak(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      snapshot.data.toString(),
                      style: TextStyle(fontSize: AppSizes.h1),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
          SizedBox(
            width: AppSizes.h1,
          ),
          Row(
            children: [
              Icon(
                Icons.crisis_alert,
                size: AppSizes.h0,
                color: AppColors.multipleColor1,
              ),
              SizedBox(
                width: AppSizes.h3 / 2,
              ),
              FutureBuilder(
                future: userRepository.getLearnedWords(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      snapshot.data.toString(),
                      style: TextStyle(fontSize: AppSizes.h1),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
        ],
      ),
      Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () => {},
              child: Icon(
                Icons.menu_outlined,
                color: AppColors.backgroundDark,
              ),
            )
          ],
        ),
      ),
    ],
  );
}