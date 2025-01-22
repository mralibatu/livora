import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livora/routes/routes.dart';
import 'package:livora/utils/app_constants.dart';
import 'package:livora/utils/main_bindings.dart';
import 'package:livora/utils/themes/app_theme.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appTitle,
      theme: AppTheme.light,
      darkTheme: AppTheme.light,
      //themeMode: ThemeMode.system,
      initialBinding: MainBindings(),
      getPages: Routes.routes,
    );
  }
}
