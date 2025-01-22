import 'package:flutter/material.dart';
import 'package:livora/utils/themes/app_colors.dart';

Align CircleAwatarWithIcon(Image image, IconData icon) {
  return Align(
    alignment: Alignment.centerLeft,
    child: SizedBox(
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
              turns: const AlwaysStoppedAnimation(25 / 360),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(0, 1.5),
                          blurRadius: 3)
                    ]),
                child: Icon(
                  icon,
                  size: 30,
                  color: AppColors.second,
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
