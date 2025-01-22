import 'package:get/get.dart';
import 'package:livora/controllers/main_controller.dart';
import 'package:livora/data/data_sources/api/api_service.dart';
import 'package:livora/data/models/list_model.dart';
import 'package:livora/data/models/word_model.dart';

class WordRepository{
  ApiService apiService = ApiService.apiService;
  MainController mainController = Get.find<MainController>();

  Future<List<Word>> fetchWords() async{
    List<Word> words = await apiService.getWords();
    print(words);
    return words;
  }

  Future<Word> fetchRandomWord() async{
    List<Word> words = await apiService.getWords();
    words.shuffle();
    return words.first;
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

  Future<List<Word>> fetchWordsByListId(int listId) async{
    List<Word> words = await apiService.getWordsByListId(listId);
    print("Fetch Words ${words.length}");
    return words;
  }

  Future<List<Word>> fetchWordsWithInfos(List<Word> words) async{
    final List<Word> wordInfos = await Future.wait(words.map((word) async {
      final wordInfo = await apiService.getWordsInfos(mainController.user!.id, word.id);
      word.isFavorite = wordInfo['is_favorite'] as bool;
      word.isLearned = wordInfo['is_learned'] as bool;
      return word;
    }));
    return wordInfos;
  }

  Future<void> updateWordInfo(Word word) async{
    await apiService.updateWordInfo(mainController.user!.id, word);
  }

  Future<List<WordList>> fetchLists() async{
    List<WordList> lists = await apiService.getWordLists();
    return lists;
  }
}