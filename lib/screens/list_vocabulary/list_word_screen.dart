import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/controllers/main_controller.dart';
import 'package:livora/data/models/category_model.dart';
import 'package:livora/data/models/word_model.dart';
import 'package:livora/data/repositories/word_repository.dart';
import 'package:livora/routes/pages.dart';
import 'package:livora/routes/routes.dart';
import 'package:livora/screens/home/widgets/custom_bottom_bar.dart';
import 'package:livora/screens/widgets/loading_indicator.dart';
import 'package:livora/utils/themes/app_colors.dart';

class WordListScreen extends StatefulWidget {
  List<Word> words;

  WordListScreen({Key? key, required this.words}) : super(key: key);

  @override
  _WordListScreenState createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> {
  WordRepository wordRepository = WordRepository();
  MainController mainController = Get.find<MainController>();

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.words.isEmpty) {
      _loadWords();
    } else {
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).iconTheme,
      ),
      backgroundColor: const Color(0xFFF8FAFC),
      bottomNavigationBar: CustomBottomNavBar(
          currentIndex: mainController.currentIndexBottomNavBar,
          onTap: (index) {
            mainController.currentIndexBottomNavBar = index;
            Get.offAndToNamed(Routes.bottomNavbarPages[index].name);
          }),
      body: isLoading
          ? const FancyLoadingIndicator()
          : Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFF8FAFC),
                    Color(0xFFE8F0FE),
                  ],
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vocabulary List',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1F36),
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Learn and practice new words',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF6B7280),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height,
                      child: ListView.builder(
                          itemCount: widget.words.length,
                          itemBuilder: (context, index) {
                            var word = widget.words[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    offset: const Offset(0, 4),
                                    blurRadius: 12,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {
                                  // Handle word selection
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            word.foreignWord,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF1A1F36),
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF4285F4)
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              'Level ${word.levelId}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF4285F4),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        word.mainLangWord,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF6B7280),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        word.hintText,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF9CA3AF),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      if (word.category != null)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF3F4F6),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            word.category!.categoryName,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF6B7280),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ]),
                ),
              ),
            ),
    );
  }

  void _loadWords() async {
    widget.words = await wordRepository.fetchWords();
    setState(() {
      isLoading = false;
    });
  }
}
