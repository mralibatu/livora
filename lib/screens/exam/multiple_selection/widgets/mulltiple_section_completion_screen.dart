import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/controllers/exam_controller.dart';
import 'package:livora/routes/pages.dart';
import 'package:livora/screens/exam/multiple_selection/multiple_selection_exam.dart';

import '../../../../data/models/exam_model.dart';

void multipleSectionCompletionScreen(BuildContext context) {
  ExamController examController = Get.find<ExamController>();
  final correctAnswers = examController.selectedAnswers.values
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
                                  examController.questions.length.toString(),
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
                                  '${((correctAnswers / examController.questions.length) * 100).toStringAsFixed(1)}%',
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
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    examController.resetExam();
                                    ExamStat examStat = await examController
                                        .examRepository
                                        .getExamStatById(
                                            examController.currentExam.id);
                                    Get.off(MultipleChoiceExam(
                                        exam: examController.currentExam,
                                        examStat: examStat));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
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
                                    ExamStat examStat = await examController
                                        .examRepository
                                        .getExamStatById(
                                            examController.currentExam.id);
                                    examStat.point = ((correctAnswers /
                                                examController
                                                    .questions.length) *
                                            100)
                                        .toInt();
                                    examStat.isCompleted = true;
                                    examController.examRepository
                                        .updateExamStats(examStat);
                                    Get.offAllNamed(Pages.home);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
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
