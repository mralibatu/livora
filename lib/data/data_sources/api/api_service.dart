import 'package:dio/dio.dart';
import 'package:livora/data/models/question_model.dart';
import '../../models/category_model.dart';
import '../../models/exam_model.dart';
import '../../models/list_model.dart';
import '../../models/user_model.dart';
import '../../models/word_model.dart';

class ApiService {

  static ApiService apiService = ApiService();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:4000/api',
      headers: {'Content-Type': 'application/json'},
    ),
  );

  // Fetch Categories
  Future<List<Category>> getCategories() async {
    final response = await _dio.get('/categories');
    return (response.data as List)
        .map((json) => Category.fromJson(json))
        .toList();
  }

  // Fetch Exams
  Future<List<Exam>> getExams() async {
    final response = await _dio.get('/exams');
    return (response.data as List).map((json) => Exam.fromJson(json)).toList();
  }

  Future<List<Exam>> getMultipleChoiceExams() async {
    final response = await _dio.get('/exams/exams');
    return (response.data as List).map((json) => Exam.fromJson(json)).toList();
  }

  Future<List<Exam>> getMatchingPairsExams() async {
    final response = await _dio.get('/exams/matchingexams');
    return (response.data as List).map((json) => Exam.fromJson(json)).toList();
  }

  // Fetch a Specific Exam
  Future<Exam> getExam(int id) async {
    final response = await _dio.get('/exams/$id');
    return Exam.fromJson(response.data);
  }

  // Create a New Exam
  Future<Exam> createExam(Exam exam) async {
    final response = await _dio.post(
      '/exams',
      data: exam.toJson(),
    );
    return Exam.fromJson(response.data);
  }

  Future<List<QuestionOption>> getQuestionsByExamId(int examId) async {
    try {
      final response = await _dio.get('/exams/$examId/questions');
      return (response.data as List)
          .map((json) => QuestionOption.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch questions for exam: $e');
    }
  }

  Future<QuestionOption> getMatchingPairsByExamId(int examId) async {
    try {
      final response = await _dio.get('/exams/$examId/questions');
      return QuestionOption.fromJson(response.data[0]);
    } catch (e) {
      throw Exception('Failed to fetch questions for exam: $e');
    }
  }

  Future<void> createQuestion(Question question) async {
    try {
      await _dio.post(
        '/questions',
        data: question.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to create question: $e');
    }
  }

  // Users
  Future<User> getUserById(int userId) async {
    try {
      final response = await _dio.get('/users/$userId');
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

  // Fetch Users
  Future<List<User>> getUsers() async {
    final response = await _dio.get('/users');
    return (response.data as List).map((json) => User.fromJson(json)).toList();
  }

  Future<User> updateUser(User user) async {
    try {
      final response = await _dio.post(
        '/users/${user.id}/update',
        data: user.toJson(),
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data['data']);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          message: 'Failed to update user: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        message: 'Error updating user: ${e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error while updating user: $e');
    }
  }


  Future<WordStats> getUserWordStats(int userId) async {
    try {
      final response = await _dio.get('/users/$userId/words');
      return WordStats.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch word stats: $e');
    }
  }

  Future<ExamStats> getUserExamStats(int userId) async {
    try {
      final response = await _dio.get('/users/$userId/examstats');
      return ExamStats.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch word stats: $e');
    }
  }

  Future<ExamStat> getUserExamStatById(int userId, int examId) async {
    try {
      final response = await _dio.get('/users/$userId/examstats/$examId');
      return ExamStat.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch word stats: $e');
    }
  }

  Future<void> updateUserExam(int userId, ExamStat examStat) async{
    await _dio.post(
      '/users/$userId/examstats/${examStat.examId}',
      data: examStat.toJson(),
    );
  }

  // Fetch Words
  Future<List<Word>> getWords() async {
    final response = await _dio.get('/words');
    return (response.data as List).map((json) => Word.fromJson(json)).toList();
  }

  // Fetch a Specific Word
  Future<Word> getWord(int id) async {
    final response = await _dio.get('/words/$id');
    return Word.fromJson(response.data);
  }

  Future<List<Word>> getWordsByCategory(int categoryId) async {
    final response = await _dio.get('/words/category/$categoryId');
    return (response.data as List).map((json) => Word.fromJson(json)).toList();
  }

  Future<List<Word>> getWordsByLevel(int levelId) async {
    final response = await _dio.get('/words/level/$levelId');
    return (response.data as List).map((json) => Word.fromJson(json)).toList();
  }

  // Create a New Word
  Future<Word> createWord(Word word) async {
    final response = await _dio.post(
      '/words',
      data: word.toJson(),
    );
    return Word.fromJson(response.data);
  }

  Future<List<WordList>> getWordLists() async {
    final response = await _dio.get('/lists');
    return (response.data as List)
        .map((json) => WordList.fromJson(json))
        .toList();
  }

  Future<WordList> getWordListById(int listId) async {
    final response = await _dio.get('/lists/$listId');
    return WordList.fromJson(response.data);
  }

  Future<Map<String, dynamic>> getWordsInfos(int userId, int wordId) async{
    final response = await _dio.get('/users/$userId/wordstats/$wordId');
    return response.data;
  }

  Future<void> updateWordInfo(int userId, Word word) async{
    try {
      final response = await _dio.post(
        '/users/$userId/wordstats/${word.id}',
        data: {
          "is_learned": word.isLearned,
          "is_favorite": word.isFavorite,
        },
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          message: 'Failed to update Word: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        message: 'Error updating Word: ${e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error while updating Word: $e');
    }
  }

  Future<WordList> createWordList(WordList wordList) async {
    final response = await _dio.post(
      '/lists',
      data: wordList.toJson(),
    );
    return WordList.fromJson(response.data);
  }

  // Fetch Words by List ID
  Future<List<Word>> getWordsByListId(int listId) async {
    final response = await _dio.get('/lists/$listId/words');
    return (response.data as List).map((json) => Word.fromJson(json)).toList();
  }

  Future<WordStats> getWordStats(int userId) async{
    final response = await _dio.get('/users/$userId/wordstats');
    return WordStats.fromJson(response.data);
  }
}
