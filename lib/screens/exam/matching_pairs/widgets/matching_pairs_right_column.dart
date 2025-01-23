import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/controllers/exam_controller.dart';

Widget matchingPairsRightColumn(BuildContext context, List<String> rightItems,
    Map<String, String> matchedPairs) {
  ExamController examController = Get.find<ExamController>();
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
            onAccept: (word) =>
                examController.handlePairsMatch(context, word, meaning),
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
