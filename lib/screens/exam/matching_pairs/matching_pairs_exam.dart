import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/controllers/exam_controller.dart';
import 'package:livora/data/models/exam_model.dart';
import 'package:livora/screens/exam/matching_pairs/widgets/matching_pairs_exam_header.dart';
import 'package:livora/screens/exam/matching_pairs/widgets/matching_pairs_left_column.dart';
import 'package:livora/screens/exam/matching_pairs/widgets/matching_pairs_right_column.dart';
import 'package:livora/screens/widgets/loading_indicator.dart';
import 'package:livora/utils/themes/app_sizes.dart';

class MatchingPairsExam extends StatefulWidget {
  MatchingPairsExam({required this.exam, required this.examStat, super.key});

  Exam exam;
  ExamStat examStat;

  @override
  State<MatchingPairsExam> createState() => _MatchingPairsExamState();
}

class _MatchingPairsExamState extends State<MatchingPairsExam>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  ExamController examController = Get.find<ExamController>();

  @override
  void initState() {
    examController.currentExam = widget.exam;
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
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
    examController.resetExam();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matching Pairs'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder(
        future: examController.loadMatchingPairsQuestions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const FancyLoadingIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Container(
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
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GetBuilder<ExamController>(
                      id: "matchingPairs",
                      builder: (controller) {
                        return Column(
                          children: [
                            matchingPairsExamHeader(
                              context,
                              controller.matchedPairs.length,
                              controller.questionPairs.length,
                            ),
                            const SizedBox(height: 24),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: matchingPairsLeftColumn(
                                      controller.leftItems,
                                      controller.matchedPairs,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: matchingPairsRightColumn(
                                      context,
                                      controller.rightItems,
                                      controller.matchedPairs,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Text(
                "Error in getting questions!",
                style: TextStyle(fontSize: AppSizes.h0),
              ),
            );
          }
        },
      ),
    );
  }
}
