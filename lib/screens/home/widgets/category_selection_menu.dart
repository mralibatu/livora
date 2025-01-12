import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/controllers/main_controller.dart';
import 'package:livora/screens/categories/categories_screen.dart';
import 'package:livora/screens/home/widgets/educational_menu_card.dart';
import 'package:livora/utils/themes/app_colors.dart';
import 'package:livora/utils/themes/app_sizes.dart';

Column CategorySelectionMenu() {
  return Column(
    children: [
      GetBuilder<MainController>(
        builder: (controller) {
          if (controller.randomCategories.isEmpty) {
            return CircularProgressIndicator();
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      EducationalMenuCard(
                        image: Image.asset("assets/images/working.png"),
                        text: controller.randomCategories[0].categoryName,
                      ),
                      EducationalMenuCard(
                        image: Image.asset("assets/images/working.png"),
                        text: controller.randomCategories[1].categoryName,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      EducationalMenuCard(
                        image: Image.asset("assets/images/working.png"),
                        text: controller.randomCategories[2].categoryName,
                      ),
                      EducationalMenuCard(
                        image: Image.asset("assets/images/working.png"),
                        text: controller.randomCategories[3].categoryName,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: GestureDetector(
          onTap: () => {Get.to(CategoriesScreen())},
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.multipleColor1,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: Colors.white,
                  ),
                  Text(
                    "More Category",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: AppSizes.h3,
                        color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}