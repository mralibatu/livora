import 'package:flutter/material.dart';

Widget matchingPairsLeftColumn(List<String> leftItems, Map<String, String> matchedPairs) {
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
      itemCount: leftItems.length,
      itemBuilder: (context, index) {
        final word = leftItems[index];
        final isMatched = matchedPairs.containsKey(word);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Opacity(
            opacity: isMatched ? 0.5 : 1.0,
            child: Draggable<String>(
              data: word,
              feedback: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade300, Colors.blue.shade600],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    word,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              childWhenDragging: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100]?.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.blue.shade200,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Text(
                  word,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[400],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isMatched ? Colors.green[100] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: isMatched
                      ? Border.all(color: Colors.green, width: 2)
                      : null,
                ),
                child: Text(
                  word,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isMatched ? Colors.green : Colors.black87,
                    fontWeight:
                    isMatched ? FontWeight.bold : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}