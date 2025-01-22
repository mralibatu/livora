import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/data/models/category_model.dart';
import 'package:livora/data/models/word_model.dart';
import 'package:livora/data/repositories/category_repository.dart';
import 'package:livora/data/repositories/word_repository.dart';
import 'package:livora/screens/categories/fancy_list_tile.dart';
import 'package:livora/screens/list_vocabulary/list_word_screen.dart';
import 'package:livora/screens/widgets/loading_indicator.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  WordRepository wordRepository = WordRepository();
  CategoryRepository categoryRepository = CategoryRepository();
  var categories = <Category>[].obs;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    categories.value = await categoryRepository.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Categories"),
      ),
      body: Obx(() {
        if (categories.isEmpty) {
          return const Center(child: FancyLoadingIndicator());
        }
        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            var category = categories[index];
            return FancyListTile(
              title: category.categoryName,
              index: index,
              showBadge: true,
              badgeText: category.wordCount == null
                  ? "0"
                  : category.wordCount.toString(),
              onTap: () async {
                List<Word> words =
                    await wordRepository.fetchWordsByCategory(category.id);
                Get.offAll(WordListScreen(words: words));
              },
            );
          },
        );
      }),
    );
  }
}
