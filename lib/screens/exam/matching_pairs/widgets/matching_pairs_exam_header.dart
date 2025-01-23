import 'package:flutter/material.dart';

Widget matchingPairsExamHeader(
    BuildContext context, int matchedPairsLength, int questionPairsLength) {
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
          value: matchedPairsLength / questionPairsLength,
          backgroundColor: Colors.grey[200],
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
      ],
    ),
  );
}
