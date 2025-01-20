import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/controllers/main_controller.dart';
import 'package:livora/data/models/list_model.dart';
import 'package:livora/data/models/word_model.dart';
import 'package:livora/data/repositories/word_repository.dart';
import 'package:livora/routes/routes.dart';
import 'package:livora/screens/flip_card/flip_card_screen.dart';
import 'package:livora/screens/home/widgets/custom_bottom_bar.dart';
import 'package:livora/screens/list_vocabulary/list_word_screen.dart';
import 'package:livora/screens/widgets/loading_indicator.dart';

class ListWordListScreen extends StatefulWidget {
  List<WordList> lists;

  ListWordListScreen({Key? key, required this.lists}) : super(key: key);

  @override
  _ListWordListScreenState createState() => _ListWordListScreenState();
}

class _ListWordListScreenState extends State<ListWordListScreen> {
  WordRepository wordRepository = WordRepository();
  MainController mainController = Get.find<MainController>();

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.lists.isEmpty) {
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
                  child: Column(
                    children: [
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
                          itemCount: widget.lists.length,
                          itemBuilder: (context, index) {
                            var list = widget.lists[index];
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
                                onTap: () async {
                                  List<Word> words = await wordRepository
                                      .fetchWordsByListId(list.id);
                                  Get.to(FlipCardListScreen(words: words));
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
                                            list.listName,
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
                                              'Repeat day : ${list.repeatDay ?? 0}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF4285F4),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void _loadWords() async {
    widget.lists = await wordRepository.fetchLists();
    setState(() {
      isLoading = false;
    });
  }
}
