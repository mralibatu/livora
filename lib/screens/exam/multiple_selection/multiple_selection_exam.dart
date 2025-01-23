import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/controllers/exam_controller.dart';
import 'package:livora/data/models/exam_model.dart';
import 'package:livora/screens/exam/multiple_selection/widgets/multiple_selection_exam_header.dart';
import 'package:livora/screens/exam/multiple_selection/widgets/multiple_selection_questions_list.dart';

class MultipleChoiceExam extends StatefulWidget {
  MultipleChoiceExam({required this.exam, required this.examStat, super.key});

  Exam exam;
  ExamStat examStat;

  @override
  State<MultipleChoiceExam> createState() => _MultipleChoiceExamState();
}

class _MultipleChoiceExamState extends State<MultipleChoiceExam>
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
        title: const Text('Multiple Choice'),
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
          child: FutureBuilder(
            future: examController.loadQuestions(),
            builder: (context, snapshot) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GetBuilder<ExamController>(
                    id: "multipleSelection",
                    builder: (controller){
                      return Column(
                        children: [
                          multipleSelectionExamHeader(context),
                          const SizedBox(height: 24),
                          Expanded(
                            child: multipleSelectionQuestionsList(),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
