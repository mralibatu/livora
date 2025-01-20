import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/controllers/main_controller.dart';
import 'package:livora/main.dart';
import 'package:livora/screens/break_daily_word/daily_word_screen.dart';
import 'package:livora/screens/categories/categories_screen.dart';
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

  Future<void> onRefresh() async {
    Random rnd = Random();
    //int seconds = 3 + rnd.nextInt(6);
    int seconds = 3;
    mainController.changeEgg(seconds);
    await Future.delayed(Duration(seconds: seconds));
    toWordPage();
    mainController.isFirstImage = true;
  }

  Future<void> toWordPage() async {
    await Future.delayed(Duration(seconds: 1));
    DailyWordSnackbar.show(
      context,
      word: "word",
      partOfSpeech: "partOfSpeech",
      definition: "definition",
      example: "example",
      displayDuration: Duration(seconds: 10),
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
              child: Image.asset("assets/images/bg-egg.png"),
              scale: 1.5,
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
                            return AnimatedSwitcher(duration: Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              child: controller.isFirstImage
                                  ? Image.asset(
                                'assets/images/just-egg.png',
                                key: ValueKey('image1'),
                              )
                                  : Image.asset(
                                'assets/images/crack-egg.png',
                                key: ValueKey('image2'),
                              ),
                            );
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
