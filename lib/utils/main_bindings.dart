import 'package:get/get.dart';
import 'package:livora/controllers/exam_controller.dart';
import 'package:livora/controllers/main_controller.dart';

class MainBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController());
    Get.put<ExamController>(ExamController());
  }
}