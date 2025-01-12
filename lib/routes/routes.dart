import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:livora/routes/pages.dart';
import 'package:livora/screens/exam/exam_selection_screen.dart';
import 'package:livora/screens/exam/exam_type_selection_screen.dart';
import 'package:livora/screens/home/home_screen.dart';

class Routes {
  static final routes = [
    GetPage(name: Pages.initial, page: () => HomeScreen()),
    GetPage(name: Pages.home, page: () => HomeScreen()),
    GetPage(name: Pages.exam_type, page: () => ExamTypeSelectionScreen()),
    GetPage(name: Pages.exam_selection, page: () => ExamSelection()),
    GetPage(name: Pages.list, page: () => HomeScreen()),
  ];


  static final bottomNavbarPages = [
    GetPage(name: Pages.home, page: () => HomeScreen()),
    GetPage(name: Pages.exam_type, page: () => ExamTypeSelectionScreen()),
    GetPage(name: Pages.list, page: () => HomeScreen()),
  ];
}
