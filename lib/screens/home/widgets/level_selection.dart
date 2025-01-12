import 'package:flutter/material.dart';
import 'package:livora/screens/home/widgets/language_level_item.dart';
import 'package:livora/utils/themes/app_sizes.dart';

Column LevelSelection() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Learn with your level",
            style: TextStyle(
              fontSize: AppSizes.h1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      FittedBox(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  LanguageLevelItem(
                    level: 'Beginner',
                    onTap: () {
                      // Handle tap event
                    },
                  ),
                  LanguageLevelItem(
                    level: 'Intermediate',
                    onTap: () {
                      // Handle tap event
                    },
                  ),
                  LanguageLevelItem(
                    level: 'Advanced',
                    onTap: () {
                      // Handle tap event
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ],
  );
}