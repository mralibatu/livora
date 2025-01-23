import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/controllers/main_controller.dart';
import 'package:livora/data/models/word_model.dart';

Widget flipCardProgress(BuildContext context,List<Word> words) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        GetBuilder<MainController>(
          id: 'progress_bar',
          builder: (controller){
            final learnedCount = words.where((word) => word.isLearned!).length;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '$learnedCount/${words.length}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: learnedCount / words.length,
                  backgroundColor: Colors.grey[200],
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}