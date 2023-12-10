

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tentwenty_movie_app/util/styles.dart';

void showCustomSnackBar(String message, {bool isError = true}) {
  if(message.isNotEmpty) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 3),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: Text(message, style: poppinsMedium),
    ));
  }
}