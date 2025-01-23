import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/controllers/main_controller.dart';
import 'package:livora/data/models/word_model.dart';
import 'package:livora/data/repositories/word_repository.dart';
import 'package:livora/screens/flip_card/widgets/flip_card_progress.dart';
import 'package:livora/screens/flip_card/widgets/flip_card_word_card.dart';
import 'package:livora/screens/widgets/loading_indicator.dart';
import 'package:livora/utils/themes/app_sizes.dart';

class FlipCardListScreen extends StatefulWidget {
  FlipCardListScreen({required this.words, super.key});

  List<Word> words;

  @override
  State<FlipCardListScreen> createState() => _FlipCardListScreenState();
}

class _FlipCardListScreenState extends State<FlipCardListScreen> {
  final PageController _pageController = PageController();
  WordRepository wordRepository = WordRepository();
  MainController mainController = Get.find<MainController>();
  bool isFinish = false;

  @override
  void initState() {
    _loadWordsInfos();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word List'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder(
        future: _loadWordsInfos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const FancyLoadingIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                flipCardProgress(context, widget.words),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.words.length,
                    itemBuilder: (context, index) {
                      return flipCardWordCard(context,widget.words[index]);
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text(
                "Failed to fetch data",
                style: TextStyle(fontSize: AppSizes.h0),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _loadWordsInfos() async {
    widget.words = await wordRepository.fetchWordsWithInfos(widget.words);
  }
}
