 

import 'package:eraser/home_controller.dart';
import 'package:eraser/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 

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
                  "assets/images/bg2.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          Center(child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30)
            ),
            height: 200,
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset("assets/images/image.png")))),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
            Text(
              "Step into a world with no background, just pure potential",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((state) {
                return Colors
                    .blue[700]; // Or dynamically calculate based on state
              })),
              onPressed:(){
                Get.to(HomePage(),transition: Transition.fade);
              },
              child: const Text(
                "Explore Now",
                style: TextStyle(color: Colors.white),
              ),
            ),
                          ],
                        ),
          ),
        ],
      ),
    );
  }
}
