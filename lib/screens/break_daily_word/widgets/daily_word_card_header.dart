import 'package:flutter/material.dart';

Widget dailyWordCardHeader(BuildContext context, VoidCallback? onClose) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      border: Border(
        bottom: BorderSide(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
        ),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.auto_awesome,
              color: Theme.of(context).primaryColor,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Word of the Day',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.close, size: 20),
          onPressed: onClose,
          color: Colors.grey[600],
        ),
      ],
    ),
  );
}
