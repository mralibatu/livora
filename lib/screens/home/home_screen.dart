import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/controllers/main_controller.dart';
import 'package:livora/data/data_sources/api/api_service.dart';
import 'package:livora/data/models/category_model.dart';
import 'package:livora/data/models/user_model.dart';
import 'package:livora/routes/routes.dart';
import 'package:livora/screens/break_daily_word/break_daily_word_screen.dart';
import 'package:livora/screens/home/widgets/category_selection_menu.dart';
import 'package:livora/screens/home/widgets/custom_bottom_bar.dart';
import 'package:livora/screens/home/widgets/home_heading.dart';
import 'package:livora/screens/widgets/snake_light_effect_icon.dart';
import 'package:livora/utils/themes/app_sizes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  MainController mainController = Get.find<MainController>();

  @override
  void initState() {
    super.initState();
  }

  var categories = <Category>[].obs;
  var users = <User>[].obs;

  Future<void> fetchApi() async {
    final ApiService apiService = ApiService();
    try {
      categories.value = await apiService.getCategories();
      users.value = await apiService.getUsers();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: mainController.currentIndexBottomNavBar,
        onTap: (index) {
          setState(() {
            print(index);
            mainController.currentIndexBottomNavBar = index;
            print(mainController.currentIndexBottomNavBar);
            Get.toNamed(Routes.bottomNavbarPages[index].name);
          });
        },
      ),
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            physics: const RangeMaintainingScrollPhysics(),
            child: Column(
              children: [
                //Start Heading
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: HomeHeading(),
                ),
                //End Heading
                //Start Header Title
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Let's Crack Your",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: AppSizes.h1,
                              ),
                            ),
                            Text(
                              "\t\t Daily Word",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: AppSizes.h0,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => {
                            Get.to(
                              const BreakDailyWordScreen(),
                            ),
                          },
                          child: SnakeSlideLightEffect(
                            icon: Icons.arrow_forward_ios,
                            size: AppSizes.h0 * 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //End Header Title
                //Start Category
                CategorySelectionMenu(),
                //End Category
                const SizedBox(
                  height: 25,
                ),
                //Start Level
                //LevelSelection(),
                //End Level

              ],
            ),
          ),
        ),
      ),
    );
  }
}
