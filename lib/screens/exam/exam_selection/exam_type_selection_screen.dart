import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/controllers/main_controller.dart';
import 'package:livora/data/models/exam_model.dart';
import 'package:livora/data/repositories/exam_repository.dart';
import 'package:livora/routes/pages.dart';
import 'package:livora/routes/routes.dart';
import 'package:livora/screens/exam/exam_selection/widgets/exam_type_selection_exam_card.dart';
import 'package:livora/screens/exam/exam_selection/widgets/exam_type_selection_header.dart';
import 'package:livora/screens/exam/matching_pairs/matching_pairs_exam.dart';
import 'package:livora/screens/exam/multiple_selection/multiple_selection_exam.dart';
import 'package:livora/screens/home/widgets/custom_bottom_bar.dart';
import 'package:livora/utils/themes/app_colors.dart';

class ExamTypeSelectionScreen extends StatefulWidget {
  const ExamTypeSelectionScreen({super.key});

  @override
  State<ExamTypeSelectionScreen> createState() =>
      _ExamTypeSelectionScreenState();
}

class _ExamTypeSelectionScreenState extends State<ExamTypeSelectionScreen>
    with SingleTickerProviderStateMixin {
  MainController mainController = Get.find<MainController>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  ExamRepository examRepository = ExamRepository();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: mainController.currentIndexBottomNavBar,
        onTap: (index) {
          setState(() {
            mainController.currentIndexBottomNavBar = index;
            Get.toNamed(Routes.bottomNavbarPages[index].name);
          });
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.05),
              Colors.white,
              Theme.of(context).primaryColor.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  examTypeSelectionHeader(context),
                  Column(
                    children: [
                      const SizedBox(height: 40),
                      examSelectionCard(
                        context: context,
                        title: 'Matching Pair Exam',
                        description: 'Match related items from two columns',
                        icon: Icons.compare_arrows,
                        gradient: AppColors.matchingPairsGradient,
                        onTap: () {
                          Get.toNamed(Pages.exam_selection, arguments: [true]);
                        },
                      ),
                      const SizedBox(height: 20),
                      examSelectionCard(
                        context: context,
                        title: 'Multiple Choice Exam',
                        description:
                            'Select the correct answer from given options',
                        icon: Icons.check_circle_outline,
                        gradient: AppColors.multipleChoiceGradient,
                        onTap: () async {
                          Get.toNamed(Pages.exam_selection, arguments: [false]);
                        },
                      ),
                      const SizedBox(height: 20),
                      examSelectionCard(
                        context: context,
                        title: 'Random Exam',
                        description: 'Let\'s solve a random exam!',
                        icon: Icons.shuffle,
                        gradient: [
                          Colors.red.shade300,
                          Colors.red.shade600,
                        ],
                        onTap: () async {
                          Exam randomExam =
                              await examRepository.getRandomExam();
                          ExamStat stats = await examRepository
                              .getExamStatById(randomExam.id);
                          if (randomExam.isMatching) {
                            Get.to(
                              MatchingPairsExam(
                                exam: randomExam,
                                examStat: stats,
                              ),
                            );
                          } else {
                            Get.to(
                              MultipleChoiceExam(
                                exam: randomExam,
                                examStat: stats,
                              ),
                            );
                          }
                        },
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