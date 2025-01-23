import 'dart:convert';
import 'package:get/get.dart';
import 'package:livora/data/data_sources/api/api_service.dart';
import 'package:livora/data/data_sources/local/local_service.dart';
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
  LocalService localService = LocalService();

  var randomCategories = <Category>[].obs;
  User? user;

  int currentIndexBottomNavBar = 0;
  bool isEggFirstImage = true;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
    fetchCategoriesAdvanced();
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

  Future<void> checkAndUpdateLoginStreak()async{
    localService.checkAndUpdateLoginStreak(user!);
  }

  Future<void> changeEgg(int seconds) async {
    await Future.delayed(Duration(milliseconds: ((seconds - 1) * 1000) - 900));
    isEggFirstImage = !isEggFirstImage;
    update(['egg']);
  }

  Future<void> updateWordInfo(Word word, String id) async {
    WordRepository wordRepository = WordRepository();
    await wordRepository.updateWordInfo(word);
    update([id,'progress_bar']);
  }
}
