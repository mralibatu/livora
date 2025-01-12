import 'package:livora/data/data_sources/api/api_service.dart';
import 'package:livora/data/models/user_model.dart';
import 'package:livora/data/models/word_model.dart';

class UserRepository{
  ApiService apiService = ApiService.apiService;

  Future<User> fetchUser(int userId) async{
    return await apiService.getUserById(userId);
  }

  Future<int> getStreak(int userId) async{
    WordStats wordStats = await apiService.getWordStats(userId);
    return wordStats.streakCount;
  }

  Future<int> getLearnedWords(int userId) async{
    WordStats wordStats = await apiService.getWordStats(userId);
    return wordStats.totalLearnedWords;
  }
}