import 'dart:io';

import 'package:eraser/home_controller.dart';
import 'package:eraser/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:before_after/before_after.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path/path.dart' as path;

class StartingPage extends StatelessWidget {
  final BackgroundRemoverController controller =
      Get.put(BackgroundRemoverController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: Get.height,
                child: Image.asset(
                  "assets/images/bg.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Step into a world with no background, just pure potential",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith((state) {
                    return Colors
                        .blueGrey; // Or dynamically calculate based on state
                  })),
                  onPressed:(){
                    Get.to(HomePage());
                  },
                  child: const Text(
                    "Explore",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
