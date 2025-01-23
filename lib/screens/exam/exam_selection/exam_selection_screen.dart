import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/data/models/exam_model.dart';
import 'package:livora/data/repositories/exam_repository.dart';
import 'package:livora/screens/exam/exam_selection/widgets/exam_selection_header.dart';
import 'package:livora/screens/exam/exam_selection/widgets/exam_selection_list_exams.dart';
import 'package:livora/screens/widgets/loading_indicator.dart';
import 'package:livora/utils/themes/app_sizes.dart';

class ExamSelection extends StatefulWidget {
  const ExamSelection({super.key});

  @override
  State<ExamSelection> createState() => _ExamSelectionState();
}

class _ExamSelectionState extends State<ExamSelection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  ExamRepository examRepository = ExamRepository();

  var isMatching = Get.arguments[0];

  List<Exam> exams = [];
  late ExamStats examStats;

  @override
  void initState() {
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
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Exams'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).primaryColor,
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
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder(
                future: loadExams(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const FancyLoadingIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        examSelectionHeader(context, exams, examStats),
                        const SizedBox(height: 24),
                        Expanded(
                          child: examSelectionListExams(exams, examStats),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Error while getting exams",
                        style: TextStyle(fontSize: AppSizes.h0),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loadExams() async {
    if (isMatching) {
      exams = await examRepository.getMatchingPairsExams();
    } else {
      exams = await examRepository.getMultipleChoiceExams();
    }
    examStats = await examRepository.getExamStats();
  }
}
