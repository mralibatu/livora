import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:livora/data/models/word_model.dart';
import 'package:livora/routes/pages.dart';
import 'package:livora/screens/break_daily_word/widgets/daily_word_card_content.dart';
import 'package:livora/screens/break_daily_word/widgets/daily_word_card_header.dart';

class DailyWordSnackbar extends StatefulWidget {
  final Word word;
  final VoidCallback? onClose;
  final Duration displayDuration;

  const DailyWordSnackbar({
    super.key,
    required this.word,
    this.onClose,
    this.displayDuration = const Duration(seconds: 5),
  });

  static void show(
    BuildContext context, {
    required Word word,
    Duration displayDuration = const Duration(seconds: 5),
  }) {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => DailyWordSnackbar(
        word: word,
        displayDuration: displayDuration,
        onClose: () {
          overlayEntry?.remove();
          Get.offAndToNamed(Pages.home);
        },
      ),
    );

    overlayState.insert(overlayEntry);

    Future.delayed(displayDuration, () {
      overlayEntry?.remove();
      Get.offAndToNamed(Pages.home);
    });
  }

  @override
  State<DailyWordSnackbar> createState() => _DailyWordSnackbarState();
}

class _DailyWordSnackbarState extends State<DailyWordSnackbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();

    // Start exit animation before the overlay is removed
    Future.delayed(widget.displayDuration - const Duration(milliseconds: 500),
        () {
      if (mounted) {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 16,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        dailyWordCardHeader(context, widget.onClose),
                        dailyWordCardContent(context, widget.word),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
