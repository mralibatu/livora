import 'package:flutter/material.dart';
import 'package:livora/controllers/main_controller.dart';

Image currentEggImage(MainController controller){
  return controller.isFirstImage
      ? Image.asset(
    'assets/images/just-egg.png',
    key: const ValueKey('image1'),
  )
      : Image.asset(
    'assets/images/crack-egg.png',
    key: const ValueKey('image2'),
  );
}