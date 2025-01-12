import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  bool _isFirstImage = true;

  Future<void> onRefresh() async {
    Random rnd = Random();
    int seconds = 3 + rnd.nextInt(6);
    changeEgg(seconds);
    await Future.delayed(Duration(seconds: seconds));
    toWordPage();
  }

  Future<void> changeEgg(int seconds) async {
    await Future.delayed(Duration(seconds: (seconds / 2).floor()));
    setState(() {
      _isFirstImage = !_isFirstImage;
    });
  }

  Future<void> toWordPage() async {
    await Future.delayed(Duration(seconds: 1));
    Get.to(CategoriesScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
                  Column(
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: _isFirstImage
                            ? Image.asset(
                                'assets/images/just-egg.png',
                                key: ValueKey('image1'),
                              )
                            : Image.asset(
                                'assets/images/crack-egg.png',
                                key: ValueKey('image2'),
                              ),
                      ),
                    ],
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
                              size: AppSizes.h0 * 6,
                            ),
                            Text(
                              "Swipe Below To Crack Your Daily Word",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: AppSizes.h0,
                                color: Colors.white,
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
