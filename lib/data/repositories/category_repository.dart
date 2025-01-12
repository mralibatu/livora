import 'dart:math';

import 'package:livora/data/data_sources/api/api_service.dart';
import 'package:livora/data/models/category_model.dart';

class CategoryRepository{
  ApiService apiService = ApiService.apiService;

  Future<List<Category>> fetchCategories() async{
    List<Category> categories = await apiService.getCategories();
    Random rnd = Random();
    rnd.nextInt(categories.length);
    categories = categories.toList().where((category) => rnd.nextBool()).take(4).toList();
    return categories;
  }
}