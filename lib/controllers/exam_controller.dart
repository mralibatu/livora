import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/data/models/exam_model.dart';
import 'package:livora/data/models/question_model.dart';
import 'package:livora/data/repositories/exam_repository.dart';
import 'package:livora/screens/exam/matching_pairs/widgets/matching_pairs_completion_screen.dart';
import 'package:livora/screens/exam/multiple_selection/widgets/mulltiple_section_completion_screen.dart';

class ExamController extends GetxController {
  ExamRepository examRepository = ExamRepository();

  late Exam currentExam;

  Map<String, String> matchedPairs = {};
  List<MatchingPair> questionPairs = [];

  late List<String> leftItems;
  late List<String> rightItems;

  List<QuestionOption> questions = [];
  final Map<int, Option> selectedAnswers = {};

  bool isCorrectMatch(String left, String right) {
    return questionPairs
        .any((pair) => pair.itemLeft == left && pair.itemRight == right);
  }

  void handlePairsMatch(BuildContext context, String word, String meaning) {
    if (isCorrectMatch(word, meaning)) {
      matchedPairs[word] = meaning;
      update(["matchingPairs"]);

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
        matchingPairsCompletionScreen(context);
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

  void handleMultipleSelectionAnswer(BuildContext context,int questionIndex, Option answer) {
    selectedAnswers[questionIndex] = answer;
    update(["multipleSelection"]);

    final isCorrect = answer.isCorrect;

    Get.snackbar(
      isCorrect ? 'Correct! 🎯' : 'Try Again! 🔄',
      isCorrect ? 'Well done!' : 'That\'s not quite right',
      snackPosition: SnackPosition.TOP,
      backgroundColor:
      (isCorrect ? Colors.green : Colors.red).withOpacity(0.9),
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
          color: (isCorrect ? Colors.green : Colors.red).withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );

    // Check if all questions are answered
    if (selectedAnswers.length == questions.length) {
      multipleSectionCompletionScreen(context);
    }
  }

  Future<void> loadMatchingPairsQuestions() async {
    QuestionOption options =
        await examRepository.getMatchingPairsByExamId(currentExam.id);

    for (var e in options.matchingPairs!) {
      questionPairs.add(e);
    }
    initializeQuestions();
  }

  Future<void> loadQuestions() async {
    questions = await examRepository.getQuestionsByExamId(currentExam.id);
  }

  void initializeQuestions() {
    leftItems = questionPairs.map((pair) => pair.itemLeft).toList()..shuffle();
    rightItems = questionPairs.map((pair) => pair.itemRight).toList()
      ..shuffle();
  }

  void resetExam(){
    matchedPairs.clear();
    questionPairs.clear();
    leftItems.clear();
    rightItems.clear();
    questions.clear();
    selectedAnswers.clear();
  }
}
