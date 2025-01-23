import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/controllers/exam_controller.dart';

Widget multipleSelectionQuestionsList() {
  ExamController examController = Get.find<ExamController>();
  return ListView.builder(
    itemCount: examController.questions.length,
    itemBuilder: (context, index) {
      final question = examController.questions[index];
      final selectedAnswer = examController.selectedAnswers[index];

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
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                question.question.questionText,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 16),
              ...List.generate(
                question.options!.length,
                (optionIndex) {
                  final option = question.options![optionIndex];
                  final isSelected = selectedAnswer == option;
                  final isCorrect = selectedAnswer != null && option.isCorrect;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      onTap: selectedAnswer == null
                          ? () => examController.handleMultipleSelectionAnswer(
                              context, index, option)
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
                                style: Theme.of(context)
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
