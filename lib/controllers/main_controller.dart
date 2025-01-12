import 'dart:convert';
import 'package:get/get.dart';
import 'package:livora/data/data_sources/api/api_service.dart';
import 'package:livora/data/models/category_model.dart';
import 'package:livora/data/models/user_model.dart';
import 'package:livora/data/repositories/category_repository.dart';
import 'package:livora/data/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController{
  CategoryRepository categoryRepository = CategoryRepository();
  UserRepository userRepository = UserRepository();
  ApiService apiService = ApiService();
  var randomCategories = <Category>[].obs;
  User? user;

  int currentIndexBottomNavBar = 0;

  @override
  void onInit() {
    fetchUser();
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async{
    randomCategories.value = await categoryRepository.fetchCategories();
  }

  Future<void> fetchCategoriesAdvanced() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? categoriesJsonList = prefs.getStringList("categories_list"); //Get Stored Categories
    if(categoriesJsonList == null){ //If there are no, fetch from api
      randomCategories.value = await categoryRepository.fetchCategories();
      List<String> jsonList = randomCategories.value.map((category) => jsonEncode(category.toJson())).toList();
      await prefs.setStringList("categories_list", jsonList);
    }else{
      List<Category> categoriesFromLocal = categoriesJsonList.map((jsonString) => Category.fromJson(jsonDecode(jsonString))).toList();
      randomCategories.value = categoriesFromLocal;
      List<Category> categoriesFromApi = await categoryRepository.fetchCategories();
      if(categoriesJsonList != categoriesFromApi){ //Categories doesnt match with api
        randomCategories.value = categoriesFromApi;
        prefs.setStringList("categories_list", randomCategories.value.map((category) => jsonEncode(category.toJson())).toList());
      }
    }
  }

  void fetchUser() async{
    user = await userRepository.fetchUser(1);
  }

}