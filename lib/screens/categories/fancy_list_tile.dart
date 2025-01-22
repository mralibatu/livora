import 'package:flutter/material.dart';
import 'package:livora/utils/themes/app_colors.dart';

class FancyListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final int index;
  final bool showBadge;
  final String? badgeText;

  const FancyListTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.index,
    this.showBadge = false,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: index.isEven
            ? AppColors.multipleColor4.withOpacity(0.7)
            : Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 12.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            children: [
              // Leading dot indicator
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index.isEven
                      ? AppColors.multipleColor1
                      : Colors.green.shade400,
                ),
              ),
              const SizedBox(width: 12),
              // Title text
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              // Optional badge
              if (showBadge) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: index.isEven
                        ? AppColors.multipleColor1.withOpacity(0.2)
                        : Colors.green.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    badgeText ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      color: index.isEven
                          ? AppColors.multipleColor1
                          : Colors.green.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
          onTap: () {
            // Add ripple effect animation
            //Future.delayed(const Duration(milliseconds: 100), onTap);
          },
        ),
      ),
    );
  }
}