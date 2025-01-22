import 'package:flutter/material.dart';
import 'package:livora/data/models/exam_model.dart';
import 'package:livora/screens/exam/widgets/exam_selection_stats.dart';

Widget examSelectionHeader(
    BuildContext context, List<Exam> exams, ExamStats examStats) {
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back! 👋',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Choose an exam to get started',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            examSelectionStats(
              context,
              'Available',
              exams.length.toString(),
              Icons.assignment_outlined,
              Colors.blue,
            ),
            const SizedBox(width: 16),
            examSelectionStats(
              context,
              'Completed',
              '${examStats.completedExams}',
              Icons.check_circle_outline,
              Colors.green,
            ),
          ],
        )
      ],
    ),
  );
}
