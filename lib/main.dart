import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tentwenty_movie_app/theme/light_theme.dart';
import 'package:tentwenty_movie_app/view/screens/upcoming_movies_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      theme: light,
      defaultTransition: Transition.topLevel,
      transitionDuration: const Duration(milliseconds: 500),
      home: const UpcomingMoviesScreen(),
    );
  }
}


