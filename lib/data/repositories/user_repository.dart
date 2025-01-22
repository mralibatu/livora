import 'package:get/get.dart';
import 'package:livora/controllers/main_controller.dart';
import 'package:livora/data/data_sources/api/api_service.dart';
import 'package:livora/data/models/user_model.dart';
import 'package:livora/data/models/word_model.dart';

class UserRepository{
  ApiService apiService = ApiService.apiService;
  //MainController mainController = Get.find<MainController>(); //There is get error in there

  Future<User> fetchUser(int userId) async{
    return await apiService.getUserById(userId);
  }

  Future<int> getStreak() async{
    WordStats wordStats = await apiService.getWordStats(1);//mainController.user!.id);
    return wordStats.streakCount;
  }

  Future<int> getLearnedWords() async{
    WordStats wordStats = await apiService.getWordStats(1);
    return wordStats.totalLearnedWords;
  }

  Future<void> updateStreak() async{
    //await apiService.updateUser(mainController.user!);
  }
}