import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:livora/routes/pages.dart';
import 'package:livora/screens/break_daily_word/break_daily_word_screen.dart';
import 'package:livora/screens/exam/exam_selection_screen.dart';
import 'package:livora/screens/exam/exam_type_selection_screen.dart';
import 'package:livora/screens/home/home_screen.dart';
import 'package:livora/screens/list_vocabulary/list_wordLists_screen.dart';
import 'package:livora/screens/splash.dart';

class Routes {
  static final routes = [
    GetPage(name: Pages.initial, page: () => SplashScreen()),
    GetPage(name: Pages.home, page: () => HomeScreen()),
    GetPage(name: Pages.exam_type, page: () => ExamTypeSelectionScreen()),
    GetPage(name: Pages.exam_selection, page: () => ExamSelection()),
    GetPage(name: Pages.list, page: () => ListWordListScreen(lists: [])),
    GetPage(name: Pages.breakDailyWord, page: () => BreakDailyWordScreen())
  ];


  static final bottomNavbarPages = [
    GetPage(name: Pages.home, page: () => HomeScreen()),
    GetPage(name: Pages.exam_type, page: () => ExamTypeSelectionScreen()),
    GetPage(name: Pages.list, page: () => ListWordListScreen(lists: [])),
  ];
}
