import 'package:livora/data/data_sources/api/api_service.dart';
import 'package:livora/data/models/word_model.dart';

class WordRepository{
  ApiService apiService = ApiService.apiService;

  Future<List<Word>> fetchWords() async{
    List<Word> words = await apiService.getWords();
    print(words);
    return words;
  }

  Future<List<Word>> fetchWordsByCategory(int categoryId) async{
    List<Word> words = await apiService.getWordsByCategory(categoryId);
    print(words);
    return words;
  }

  Future<List<Word>> fetchWordsByLevel(int levelId) async{
    List<Word> words = await apiService.getWordsByLevel(levelId);
    print(words);
    return words;
  }
}