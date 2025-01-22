import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/data/models/exam_model.dart';
import 'package:livora/data/models/question_model.dart';
import 'package:livora/data/repositories/exam_repository.dart';
import 'package:livora/routes/pages.dart';
import 'package:livora/screens/exam/exam_type_selection_screen.dart';
import 'package:livora/screens/widgets/loading_indicator.dart';

class MultipleChoiceExam extends StatefulWidget {
  MultipleChoiceExam({required this.exam,required this.examStat,super.key});

  Exam exam;
  ExamStat examStat;

  @override
  State<MultipleChoiceExam> createState() => _MultipleChoiceExamState();
}

class _MultipleChoiceExamState extends State<MultipleChoiceExam>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  ExamRepository examRepository = ExamRepository();
  List<QuestionOption> questions = [];

  var isLoading = true;

  // Keep track of selected answers
  final Map<int, Option> selectedAnswers = {};

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

  void _handleAnswer(int questionIndex, Option answer) {
    setState(() {
      selectedAnswers[questionIndex] = answer;
    });

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
      _showCompletionScreen();
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
        title: const Text('Multiple Choice'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme
            .of(context)
            .primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme
                  .of(context)
                  .primaryColor
                  .withOpacity(0.05),
              Colors.white,
              Theme
                  .of(context)
                  .primaryColor
                  .withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: isLoading ? const FancyLoadingIndicator() : FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 24),
                  Expanded(
                    child: _buildQuestionsList(),
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
            'Multiple Choice Quiz',
            style: Theme
                .of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme
                  .of(context)
                  .primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select the correct answer for each question',
            style: Theme
                .of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: selectedAnswers.length / questions.length,
            backgroundColor: Colors.grey[200],
            color: Theme
                .of(context)
                .primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionsList() {
    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
        final selectedAnswer = selectedAnswers[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Question ${index + 1}',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  question.question.questionText,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                ...List.generate(
                  question.options!.length,
                      (optionIndex) {
                    final option = question.options![optionIndex];
                    final isSelected = selectedAnswer == option;
                    final isCorrect = selectedAnswer != null &&
                        option.isCorrect;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: InkWell(
                        onTap: selectedAnswer == null
                            ? () => _handleAnswer(index, option)
                            : null,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (isCorrect
                                ? Colors.green.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1))
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? (isCorrect ? Colors.green : Colors.red)
                                  : Colors.grey[300]!,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isSelected
                                    ? (isCorrect
                                    ? Icons.check_circle_outline
                                    : Icons.cancel_outlined)
                                    : Icons.radio_button_unchecked,
                                color: isSelected
                                    ? (isCorrect ? Colors.green : Colors.red)
                                    : Colors.grey[400],
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  option.optionText,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                    color: isSelected
                                        ? (isCorrect
                                        ? Colors.green
                                        : Colors.red)
                                        : Colors.black87,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void _showCompletionScreen() {
    final correctAnswers = selectedAnswers.values
        .where((option) => option.isCorrect)
        .length;
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
                              'Quiz Completed! 🎉',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Here\'s how you did:',
                              textAlign: TextAlign.center,
                              style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 32),
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
                                    'Total Questions',
                                    questions.length.toString(),
                                    Icons.quiz_rounded,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildStatRow(
                                    context,
                                    'Correct Answers',
                                    correctAnswers.toString(),
                                    Icons.check_circle_outline_rounded,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildStatRow(
                                    context,
                                    'Score',
                                    '${((correctAnswers / questions.length) * 100).toStringAsFixed(1)}%',
                                    Icons.score_rounded,
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
                                        Get.off(MultipleChoiceExam(exam: widget.exam, examStat: widget.examStat));
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
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      ExamStat examStat = await examRepository.getExamStatById(widget.exam.id);
                                      examStat.point = ((correctAnswers / questions.length) * 100).toInt();
                                      examStat.isCompleted = true;
                                      examRepository.updateExamStats(examStat);
                                      Get.offAllNamed(Pages.home);
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
    questions = await examRepository.getQuestionsByExamId(widget.exam.id);
    setState(() {
      isLoading = false; // Update state after questions are loaded
    });
  }
}