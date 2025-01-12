
import 'package:flutter/material.dart';
import 'package:livora/utils/themes/app_colors.dart';

class LanguageLevelItem extends StatelessWidget {
  final String level;
  final bool isSelected;
  final VoidCallback? onTap;

  const LanguageLevelItem({
    Key? key,
    required this.level,
    this.isSelected = true,
    this.onTap,
  }) : super(key: key);

  Color _getLevelColor() {
    switch (level.toLowerCase()) {
      case 'beginner':
        return Colors.green;
      case 'intermediate':
        return Colors.orange;
      case 'advanced':
        return Colors.red;
      default:
        return AppColors.multipleColor1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected
                    ? _getLevelColor().withOpacity(0.1)
                    : Colors.transparent,
                border: Border.all(
                  color: _getLevelColor(),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: _getLevelColor().withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 1,
                  )
                ]
                    : [],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Optional: Background indicator
                  if (isSelected)
                    Positioned(
                      right: 0,
                      child: Icon(
                        Icons.check_circle,
                        color: _getLevelColor().withOpacity(0.2),
                        size: 20,
                      ),
                    ),

                  // Main content
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        level.toUpperCase(),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                          color: _getLevelColor(),
                          letterSpacing: 1.2,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Level indicator dots
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          level.toLowerCase() == 'beginner'
                              ? 1
                              : level.toLowerCase() == 'intermediate'
                              ? 2
                              : 3,
                              (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _getLevelColor().withOpacity(0.7),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}