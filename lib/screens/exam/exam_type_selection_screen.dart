import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/controllers/main_controller.dart';
import 'package:livora/data/data_sources/api/api_service.dart';
import 'package:livora/data/models/exam_model.dart';
import 'package:livora/data/repositories/exam_repository.dart';
import 'package:livora/routes/pages.dart';
import 'package:livora/routes/routes.dart';
import 'package:livora/screens/exam/matching_pairs_exam.dart';
import 'package:livora/screens/exam/multiple_selection_exam.dart';
import 'package:livora/screens/home/widgets/custom_bottom_bar.dart';

class ExamTypeSelectionScreen extends StatefulWidget {
  ExamTypeSelectionScreen({super.key});

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
                  _buildHeader(context),
                  Column(
                    children: [
                      const SizedBox(height: 40),
                      _buildExamTypeCard(
                        context: context,
                        title: 'Matching Pair Exam',
                        description: 'Match related items from two columns',
                        icon: Icons.compare_arrows,
                        gradient: [
                          Colors.blue.shade300,
                          Colors.blue.shade600,
                        ],
                        onTap: () {
                          Get.toNamed(Pages.exam_selection);
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildExamTypeCard(
                        context: context,
                        title: 'Multiple Choice Exam',
                        description:
                            'Select the correct answer from given options',
                        icon: Icons.check_circle_outline,
                        gradient: [
                          Colors.purple.shade300,
                          Colors.purple.shade600,
                        ],
                        onTap: () async {
                          Get.toNamed(Pages.exam_selection);
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildExamTypeCard(
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Exam Type',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            'Choose the type of exam you want to take',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamTypeCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradient.last.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.9),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
