import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/controllers/main_controller.dart';
import 'package:livora/data/models/word_model.dart';
import 'package:livora/data/repositories/word_repository.dart';
import 'package:livora/screens/categories/categories_screen.dart';
import 'package:livora/screens/home/widgets/educational_menu_card.dart';
import 'package:livora/screens/list_vocabulary/list_word_screen.dart';
import 'package:livora/screens/widgets/loading_indicator.dart';
import 'package:livora/utils/themes/app_colors.dart';
import 'package:livora/utils/themes/app_sizes.dart';

Column CategorySelectionMenu() {
  WordRepository wordRepository = WordRepository();
  return Column(
    children: [
      GetBuilder<MainController>(
        builder: (controller) {
          if (controller.randomCategories.isEmpty) {
            return const FancyLoadingIndicator();
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
                        onTap: () async {
                          List<Word> words = await wordRepository.fetchWordsByCategory(controller.randomCategories[0].id);
                          Get.to(() => WordListScreen(words: words));
                        },
                      ),
                      EducationalMenuCard(
                        image: Image.asset("assets/images/working.png"),
                        text: controller.randomCategories[1].categoryName,
                        onTap: () async {
                          List<Word> words = await wordRepository.fetchWordsByCategory(controller.randomCategories[1].id);
                          Get.to(WordListScreen(words: words,));
                        },
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
                        onTap: () async {
                          List<Word> words = await wordRepository.fetchWordsByCategory(controller.randomCategories[2].id);
                          Get.to(WordListScreen(words: words,));
                        },
                      ),
                      EducationalMenuCard(
                        image: Image.asset("assets/images/working.png"),
                        text: controller.randomCategories[3].categoryName,
                        onTap: () async {
                          List<Word> words = await wordRepository.fetchWordsByCategory(controller.randomCategories[3].id);
                          Get.to(() => WordListScreen(words: words));
                        },
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GestureDetector(
          onTap: () => {Get.to(const CategoriesScreen())},
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.multipleColor1,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
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