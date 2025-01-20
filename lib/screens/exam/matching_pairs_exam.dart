import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/data/models/exam_model.dart';
import 'package:livora/data/models/question_model.dart';
import 'package:livora/data/repositories/exam_repository.dart';
import 'package:livora/routes/pages.dart';
import 'package:livora/screens/widgets/loading_indicator.dart';

class MatchingPairsExam extends StatefulWidget {
  MatchingPairsExam({required this.exam,required this.examStat,super.key});

  Exam exam;
  ExamStat examStat;

  @override
  State<MatchingPairsExam> createState() => _MatchingPairsExamState();
}

class _MatchingPairsExamState extends State<MatchingPairsExam>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  ExamRepository examRepository = ExamRepository();

  var isLoading = true;

  // Keep track of matched pairs
  Map<String, String> matchedPairs = {};

  // Sample question data - Replace with your actual data
  List<MatchingPair> questionPairs = [];

  // Shuffled lists for display
  late List<String> leftItems;
  late List<String> rightItems;

  @override
  void initState() {
    _loadQuestions();
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  void _initializeQuestions() {
    leftItems = questionPairs.map((pair) => pair.itemLeft).toList()..shuffle();
    rightItems = questionPairs.map((pair) => pair.itemRight).toList()..shuffle();
  }

  bool isCorrectMatch(String left, String right) {
    return questionPairs.any((pair) =>
    pair.itemLeft == left && pair.itemRight == right);
  }

  void _handleMatch(String word, String meaning) {
    if (isCorrectMatch(word, meaning)) {
      setState(() {
        matchedPairs[word] = meaning;
      });

      // Show success feedback
      Get.snackbar(
        'Excellent! 🎯',
        'Correct match!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.9),
        colorText: Colors.white,
        borderRadius: 16,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 1),
        animationDuration: const Duration(milliseconds: 500),
        snackStyle: SnackStyle.FLOATING,
        overlayColor: Colors.black12,
        overlayBlur: 0,
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.easeInBack,
        boxShadows: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      );
      // Check if all pairs are matched
      if (matchedPairs.length == questionPairs.length) {
        _showCompletionScreen();
      }
    } else {
      // Wrong match
      Get.snackbar(
        'Try Again! 🔄',
        'Not quite right, keep going!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
        borderRadius: 16,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 1),
        animationDuration: const Duration(seconds: 1),
        snackStyle: SnackStyle.FLOATING,
        overlayColor: Colors.black12,
        overlayBlur: 0,
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.easeInBack,
        boxShadows: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matching Pairs'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).primaryColor,
      ),
      body: isLoading ? FancyLoadingIndicator() : Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.05),
              Colors.white,
              Theme.of(context).primaryColor.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Row(
                      children: [
                        // Left column (words)
                        Expanded(
                          child: _buildLeftColumn(),
                        ),
                        const SizedBox(width: 16),
                        // Right column (meanings)
                        Expanded(
                          child: _buildRightColumn(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Match the Words',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Drag words from left to right to match them',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: matchedPairs.length / questionPairs.length,
            backgroundColor: Colors.grey[200],
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftColumn() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: leftItems.length,
        itemBuilder: (context, index) {
          final word = leftItems[index];
          final isMatched = matchedPairs.containsKey(word);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Opacity(
              opacity: isMatched ? 0.5 : 1.0,
              child: Draggable<String>(
                data: word,
                feedback: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade300, Colors.blue.shade600],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      word,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                childWhenDragging: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100]?.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.blue.shade200,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Text(
                    word,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[400],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isMatched ? Colors.green[100] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: isMatched
                        ? Border.all(color: Colors.green, width: 2)
                        : null,
                  ),
                  child: Text(
                    word,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isMatched ? Colors.green : Colors.black87,
                      fontWeight:
                      isMatched ? FontWeight.bold : FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRightColumn() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: rightItems.length,
        itemBuilder: (context, index) {
          final meaning = rightItems[index];
          final isMatched = matchedPairs.containsValue(meaning);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: DragTarget<String>(
              onWillAccept: (data) => !isMatched,
              onAccept: (word) => _handleMatch(word, meaning),
              builder: (context, candidateData, rejectedData) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: isMatched
                        ? LinearGradient(
                      colors: [
                        Colors.purple.shade300,
                        Colors.purple.shade600
                      ],
                    )
                        : null,
                    color: isMatched
                        ? null
                        : candidateData.isNotEmpty
                        ? Colors.purple[50]
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: candidateData.isNotEmpty && !isMatched
                        ? Border.all(
                      color: Colors.purple,
                      width: 2,
                      style: BorderStyle.solid,
                    )
                        : null,
                    boxShadow: isMatched
                        ? [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                        : null,
                  ),
                  child: Text(
                    meaning,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isMatched
                          ? Colors.white
                          : candidateData.isNotEmpty
                          ? Colors.purple
                          : Colors.black87,
                      fontWeight: isMatched || candidateData.isNotEmpty
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }


  void _showCompletionScreen() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  // Drag handle
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Trophy animation container
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.emoji_events_rounded,
                                size: 80,
                                color: Colors.amber,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Congratulations! 🎉',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'You\'ve successfully matched all pairs!',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 32),
                            // Stats container
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.grey[200]!,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  _buildStatRow(
                                    context,
                                    'Total Pairs',
                                    '${questionPairs.length}',
                                    Icons.compare_arrows_rounded,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildStatRow(
                                    context,
                                    'Completed',
                                    '100%',
                                    Icons.check_circle_outline_rounded,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                            // Action buttons
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        matchedPairs.clear();
                                        _initializeQuestions();
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      backgroundColor: Theme.of(context).primaryColor,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text('Try Again'),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Get.toNamed(Pages.exam_selection);
                                    },
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      side: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text('Exit'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStatRow(
      BuildContext context,
      String label,
      String value,
      IconData icon,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  void _loadQuestions() async {
    QuestionOption options = await examRepository.getMatchingPairsByExamId(widget.exam.id);

    options.matchingPairs!.forEach((e) => questionPairs.add(e));
    print(questionPairs);
    _initializeQuestions();
    setState(() {
      isLoading = false; // Update state after questions are loaded
    });
  }
}