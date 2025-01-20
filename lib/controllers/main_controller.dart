import 'dart:convert';
import 'package:get/get.dart';
import 'package:livora/data/data_sources/api/api_service.dart';
import 'package:livora/data/models/category_model.dart';
import 'package:livora/data/models/user_model.dart';
import 'package:livora/data/repositories/category_repository.dart';
import 'package:livora/data/repositories/user_repository.dart';
import 'package:livora/data/repositories/word_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/word_model.dart';

class MainController extends GetxController {
  CategoryRepository categoryRepository = CategoryRepository();
  UserRepository userRepository = UserRepository();
  ApiService apiService = ApiService();
  var randomCategories = <Category>[].obs;
  User? user;

  int currentIndexBottomNavBar = 0;
  bool isFirstImage = true;

  static const String LAST_LOGIN_KEY = 'last_login_date';
  static const String CURRENT_STREAK_KEY = 'current_streak';

  @override
  void onInit() {
    fetchUser();
    fetchCategoriesAdvanced();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    randomCategories.value = await categoryRepository.fetchRandomCategories();
    update();
  }

  Future<void> fetchCategoriesAdvanced() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? categoriesJsonList =
        prefs.getStringList("categories_list"); //Get Stored Categories
    if (categoriesJsonList == null) {
      //If there are no, fetch from api
      randomCategories.value = await categoryRepository.fetchRandomCategories();
      List<String> jsonList = randomCategories.value
          .map((category) => jsonEncode(category.toJson()))
          .toList();
      await prefs.setStringList("categories_list", jsonList);
    } else {
      List<Category> categoriesFromLocal = categoriesJsonList
          .map((jsonString) => Category.fromJson(jsonDecode(jsonString)))
          .toList();
      randomCategories.value = categoriesFromLocal;
      List<Category> categoriesFromApi =
          await categoryRepository.fetchRandomCategories();
      if (categoriesJsonList != categoriesFromApi) {
        //Categories doesnt match with api
        randomCategories.value = categoriesFromApi;
        prefs.setStringList(
            "categories_list",
            randomCategories.value
                .map((category) => jsonEncode(category.toJson()))
                .toList());
      }
    }
    update();
  }

  void fetchUser() async {
    user = await userRepository.fetchUser(1);
  }

  Future<void> changeEgg(int seconds) async {
    await Future.delayed(Duration(milliseconds: ((seconds - 1) * 1000) - 900));
    isFirstImage = !isFirstImage;
    update(['egg']);
  }

  Future<void> checkAndUpdateLoginStreak() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastLoginStr = prefs.getString(LAST_LOGIN_KEY);
    int currentStreak = prefs.getInt(CURRENT_STREAK_KEY) ?? 0;

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    if (lastLoginStr != null) {
      DateTime lastLogin = DateTime.parse(lastLoginStr);
      DateTime lastLoginDate =
          DateTime(lastLogin.year, lastLogin.month, lastLogin.day);

      Duration difference = today.difference(lastLoginDate);

      if (difference.inDays == 1) {
        // Add streak
        currentStreak++;
      } else if (difference.inDays == 0) {
        // Same day
        return;
      } else {
        // Streak is gone
        currentStreak = 1;
      }
    } else {
      // First time login
      currentStreak = 1;
    }

    // Update
    await prefs.setString(LAST_LOGIN_KEY, today.toIso8601String());
    await prefs.setInt(CURRENT_STREAK_KEY, currentStreak);

    // Update streak on the server
    try {
      user!.streakCount++;
      await userRepository.updateStreak();
    } catch (e) {
      print('Failed to update streak on server: $e');
    }
  }

  Future<void> updateWordInfo(Word word, String id) async {
    WordRepository wordRepository = WordRepository();
    await wordRepository.updateWordInfo(word);
    update([id,'progress_bar']);
  }
}
