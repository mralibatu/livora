import 'package:livora/data/data_sources/api/api_service.dart';
import 'package:livora/data/models/question_model.dart';

class ExamRepository {
  ApiService apiService = ApiService.apiService;

  Future<List<QuestionOption>> getQuestionsByExamId(int examId) async {
    return  await apiService.getQuestionsByExamId(examId);
  }

}
