import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/controllers/exam_controller.dart';
import 'package:livora/data/models/exam_model.dart';
import 'package:livora/data/repositories/exam_repository.dart';
import 'package:livora/routes/pages.dart';

void matchingPairsCompletionScreen(BuildContext context) {
  ExamRepository examRepository = ExamRepository();
  ExamController examController = Get.find<ExamController>();
  Exam exam = examController.currentExam;
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
                            'You\'ve successfully matched all pairs!',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                                  '${examController.matchedPairs.length}',
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
                                    //Update
                                    examController.matchedPairs.clear();
                                    examController.initializeQuestions();
                                    examController.update(["matchingPairs"]);
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
                                    ExamStat examStat = await examRepository
                                        .getExamStatById(exam.id);
                                    examStat.point = 100;
                                    examStat.isCompleted = true;
                                    examRepository.updateExamStats(examStat);
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
