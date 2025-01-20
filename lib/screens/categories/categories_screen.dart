import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/data/models/category_model.dart';
import 'package:livora/data/models/word_model.dart';
import 'package:livora/data/repositories/category_repository.dart';
import 'package:livora/data/repositories/word_repository.dart';
import 'package:livora/screens/list_vocabulary/list_word_screen.dart';
import 'package:livora/utils/themes/app_colors.dart';

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
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            var category = categories[index];

            return FancyListTile(
              title: category.categoryName,
              index: index,
              showBadge: true,
              badgeText: category.wordCount == null ? "0" : category.wordCount.toString(),
              onTap: () async {
                List<Word> words = await wordRepository.fetchWordsByCategory(category.id);
                Get.offAll(WordListScreen(words: words));
              },
            );
          },
        );
      }),
    );
  }
}

class FancyListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final int index;
  final bool showBadge;
  final String? badgeText;

  const FancyListTile({
    Key? key,
    required this.title,
    required this.onTap,
    required this.index,
    this.showBadge = false,
    this.badgeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: index.isEven
            ? AppColors.multipleColor4.withOpacity(0.7)
            : Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 12.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            children: [
              // Leading dot indicator
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index.isEven
                      ? AppColors.multipleColor1
                      : Colors.green.shade400,
                ),
              ),
              const SizedBox(width: 12),
              // Title text
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              // Optional badge
              if (showBadge) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: index.isEven
                        ? AppColors.multipleColor1.withOpacity(0.2)
                        : Colors.green.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    badgeText ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      color: index.isEven
                          ? AppColors.multipleColor1
                          : Colors.green.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
          onTap: () {
            // Add ripple effect animation
            Future.delayed(const Duration(milliseconds: 100), onTap);
          },
        ),
      ),
    );
  }
}
