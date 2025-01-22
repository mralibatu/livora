import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/data/models/exam_model.dart';
import 'package:livora/screens/exam/matching_pairs_exam.dart';
import 'package:livora/screens/exam/multiple_selection_exam.dart';
import 'package:livora/utils/common_methods/common_methods.dart';
import 'package:livora/utils/themes/app_colors.dart';

Widget examSelectionListExams(List<Exam> exams, ExamStats examStats) {
  return ListView.builder(
    itemCount: exams.length,
    itemBuilder: (context, index) {
      final exam = exams[index];
      int score =
          examStats.examStats.where((e) => e.examId == exam.id).first.point;
      Color scoreColor = CommonMethods.getScoreColor(score);
      Color examColor = exam.isMatching
          ? AppColors.matchingPairsGradient.last.withOpacity(0.3)
          : AppColors.multipleChoiceGradient.last.withOpacity(0.3);
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
        child: InkWell(
          onTap: () async {
            // Navigate to the appropriate exam type
            if (!exam.isMatching) {
              Get.offAll(
                () => MultipleChoiceExam(
                  exam: exam,
                  examStat: examStats.examStats[index],
                ),
              );
            } else {
              Get.offAll(
                () => MatchingPairsExam(
                  exam: exam,
                  examStat: examStats.examStats[index],
                ),
              );
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: examColor,
                      ),
                      child: Icon(
                        exam.isMatching
                            ? Icons.compare_arrows
                            : Icons.check_circle_outline,
                        color: examColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exam.examName,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            exam.username,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey[600],
                                ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    examDetail(
                      context,
                      Icons.timer_outlined,
                      exam.timerSeconds == null
                          ? "No Limit"
                          : '${(exam.timerSeconds! / 60).ceil()} Minutes',
                      Colors.orange,
                    ),
                    const SizedBox(width: 16),
                    examDetail(
                      context,
                      Icons.trending_up_rounded,
                      score.toString(),
                      scoreColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget examDetail(
  BuildContext context,
  IconData icon,
  String label,
  Color color,
) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 16,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}
