import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:get/get.dart';
import 'package:livora/controllers/main_controller.dart';
import 'package:livora/data/models/word_model.dart';
import 'package:livora/data/repositories/word_repository.dart';
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
    print("Print ${widget.words.length}");
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
                _buildProgress(),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.words.length,
                    itemBuilder: (context, index) {
                      return _buildWordCard(widget.words[index]);
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

  Widget _buildProgress() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          GetBuilder<MainController>(
            id: 'progress_bar',
            builder: (controller){
              final learnedCount = widget.words.where((word) => word.isLearned!).length;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        '$learnedCount/${widget.words.length}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: learnedCount / widget.words.length,
                    backgroundColor: Colors.grey[200],
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWordCard(Word word) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: FlipCard(
              fill: Fill.fillBack,
              direction: FlipDirection.VERTICAL,
              side: CardSide.FRONT,
              front: _buildCardSide(
                word.foreignWord,
                'Tap to see translation',
                Theme.of(context).primaryColor,
              ),
              back: _buildCardSide(
                word.mainLangWord,
                'Tap to see word',
                Theme.of(context).primaryColor.withOpacity(0.8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildActionButtons(word),
        ],
      ),
    );
  }

  Widget _buildCardSide(String text, String subtitle, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(Word word) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GetBuilder<MainController>(
          id: 'is_learned',
          builder: (controller) {
            return _buildActionButton(
              icon: word.isLearned!
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
              label: word.isLearned! ? 'Learned' : 'Mark as Learned',
              color: word.isLearned! ? Colors.green : Colors.grey,
              onPressed: () {
                word.isLearned = !word.isLearned!;
                if (word.isLearned!) {
                  _showSuccessSnackbar('Word marked as learned!');
                }
                controller.updateWordInfo(word, 'is_learned');
              },
            );
          },
        ),
        GetBuilder<MainController>(
          id: 'is_favorite',
          builder: (controller) {
            return _buildActionButton(
              icon: word.isFavorite! ? Icons.favorite : Icons.favorite_border,
              label: word.isFavorite! ? 'Favorited' : 'Add to Favorites',
              color: word.isFavorite! ? Colors.red : Colors.grey,
              onPressed: () {
                word.isFavorite = !word.isFavorite!;
                if (word.isFavorite!) {
                  _showSuccessSnackbar('Word marked as favorite!');
                }
                controller.updateWordInfo(word, 'is_favorite');
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(color: color, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.withOpacity(0.9),
      colorText: Colors.white,
      borderRadius: 16,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 500),
      snackStyle: SnackStyle.FLOATING,
    );
  }

  Future<void> _loadWordsInfos() async {
    widget.words = await wordRepository.fetchWordsWithInfos(widget.words);
    isFinish = true;
  }
}
