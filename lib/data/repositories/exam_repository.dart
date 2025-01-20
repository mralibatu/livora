import 'package:get/get.dart';
import 'package:livora/controllers/main_controller.dart';
import 'package:livora/data/data_sources/api/api_service.dart';
import 'package:livora/data/models/exam_model.dart';
import 'package:livora/data/models/question_model.dart';

class ExamRepository {
  ApiService apiService = ApiService.apiService;
  MainController mainController = Get.find<MainController>();

  Future<List<Exam>> getExams() async{
    return await apiService.getExams();
  }

  Future<ExamStats> getExamStats() async{
    return await apiService.getUserExamStats(mainController.user!.id);
  }

  Future<ExamStat> getExamStatById(int examId) async{
    return await apiService.getUserExamStatById(mainController.user!.id, examId);
  }

  Future<List<QuestionOption>> getQuestionsByExamId(int examId) async {
    return await apiService.getQuestionsByExamId(examId);
  }

  Future<QuestionOption> getMatchingPairsByExamId(int examId) async{
    return await apiService.getMatchingPairsByExamId(examId);
  }

  Future<Exam> getRandomExam() async{
    List<Exam> exams = await apiService.getExams();
    exams.shuffle();
    return exams.first;
  }
}
