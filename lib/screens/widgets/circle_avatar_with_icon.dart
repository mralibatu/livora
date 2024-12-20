import 'package:flutter/material.dart';
import 'package:livora/utils/themes/app_colors.dart';

Align CircleAwatarWithIcon(Image image, IconData icon) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      width: 70,
      child: Stack(
        children: [
          CircleAvatar(
            backgroundImage: image.image,
            backgroundColor: Colors.blueAccent,
            radius: 35,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(25 / 360),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(color: AppColors.second.withOpacity(0.3), offset: Offset(0, 1.5),blurRadius: 5)
                  ]
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: AppColors.primary,
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}