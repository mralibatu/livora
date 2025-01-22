import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/utils/themes/app_colors.dart';
import 'package:livora/utils/themes/app_sizes.dart';

class EducationalMenuCard extends StatelessWidget {
  final Image image;
  final String text;
  final VoidCallback? onTap;
  final Color? customColor;

  const EducationalMenuCard({
    Key? key,
    required this.image,
    required this.text,
    this.onTap,
    this.customColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height * 0.25,
        width: Get.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              customColor ?? AppColors.multipleColor1,
              customColor?.withOpacity(0.8) ??
                  AppColors.multipleColor1.withOpacity(0.8),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background pattern (optional)
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image with container
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(0.9),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: image),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Text with improved styling
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                            fontSize: AppSizes.h2,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            shadows: [
                              Shadow(
                                offset: const Offset(1, 1),
                                blurRadius: 2,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 4),

                        // Optional: Add a subtle indicator
                        Container(
                          height: 3,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
