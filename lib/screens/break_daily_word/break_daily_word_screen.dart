import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/controllers/main_controller.dart';
import 'package:livora/data/models/word_model.dart';
import 'package:livora/data/repositories/word_repository.dart';
import 'package:livora/screens/break_daily_word/daily_word_screen.dart';
import 'package:livora/screens/break_daily_word/widgets/current_egg_image.dart';
import 'package:livora/screens/widgets/ball_indicator.dart';
import 'package:livora/screens/widgets/snake_light_effect_icon.dart';
import 'package:livora/utils/themes/app_sizes.dart';

class BreakDailyWordScreen extends StatefulWidget {
  const BreakDailyWordScreen({super.key});

  @override
  State<BreakDailyWordScreen> createState() => _BreakDailyWordScreenState();
}

class _BreakDailyWordScreenState extends State<BreakDailyWordScreen>
    with SingleTickerProviderStateMixin {
  MainController mainController = Get.find<MainController>();
  WordRepository wordRepository = WordRepository();

  Future<void> onRefresh() async {
    int seconds = 3;
    mainController.changeEgg(seconds);
    await Future.delayed(Duration(seconds: seconds));
    toWordPage();
    mainController.isFirstImage = true;
  }

  Future<void> toWordPage() async {
    Word word = await wordRepository.fetchRandomWord();
    DailyWordSnackbar.show(
      context,
      word: word,
      displayDuration: const Duration(seconds: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Center(
            child: Transform.scale(
              scale: 1.5,
              child: Image.asset("assets/images/bg-egg.png"),
            ),
          ),
          BallIndicator(
            onRefresh: onRefresh,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  SizedBox(
                    height: Get.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GetBuilder<MainController>(
                          id: 'egg',
                          builder: (controller) {
                            return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                transitionBuilder: (child, animation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                                child: currentEggImage(controller));
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: Get.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SnakeSlideLightEffect(
                              icon: Icons.keyboard_double_arrow_down,
                              slideDirection: SlideDirection.topToBottom,
                              size: AppSizes.h0 * 4,
                            ),
                            Text(
                              "Swipe Below To Crack Your Daily Word",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: AppSizes.h0,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
