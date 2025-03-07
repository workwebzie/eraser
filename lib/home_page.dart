import 'dart:io';
import 'dart:ui';
import 'package:eraser/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:before_after/before_after.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path/path.dart' as path;

class HomePage extends StatelessWidget {
  final BackgroundRemoverController controller =
      Get.put(BackgroundRemoverController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.home,
              color: Colors.white,
            )),
        backgroundColor: Colors.transparent,
        title: Text(
          controller.imagePath.value != "" ? "Eraser" : "",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Obx(
            () => Visibility(
              visible: controller.removed.isTrue,
              child: IconButton(
                onPressed: () {
                  if (controller.imagePath.isNotEmpty) {
                    String fileName = path.basename(
                        controller.imagePath.value); // Extract filename
                    controller.downloadToExternal(fileName);
                  } else {
                    print("No image selected");
                  }
                },
                icon: Icon(
                  Icons.download,
                  color: controller.imagePath.isNotEmpty
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
      body: Obx(
        () => controller.imagePath.value != ""
            ? Stack(
                children: [
                  Obx(
                    () => Positioned.fill(
                        child: Image.file(
                      File(controller.imagePath.value),
                      fit: BoxFit.cover,
                    )),
                  ),
                  Positioned.fill(
                    child: Obx(
                      () => BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: controller.imagePath.value == "" ? 0 : 30,
                            sigmaY: controller.imagePath.value == "" ? 0 : 30),
                        child: Container(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Obx(() {
                        if (controller.removed.value) {
                          return Container(
                            height: Get.height / 2,
                            child: BeforeAfter(
                              value: controller.value.value,
                              after: Image.file(
                                  File(controller.imagePath.value),
                                  fit: BoxFit.cover),
                              before: Screenshot(
                                controller: controller.screenshotController,
                                child: Image.memory(controller.image!,
                                    fit: BoxFit.cover),
                              ),
                              direction: SliderDirection.horizontal,
                              onValueChanged: (val) =>
                                  controller.value.value = val,
                            ),
                          );
                        }

                        return Container(
                          height: Get.height / 2,
                          child: Image.file(File(controller.imagePath.value),
                              fit: BoxFit.cover),
                        );
                      }),
                    ),
                  ),
                ],
              )
            : Container(
                child: Center(
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor:
                        WidgetStateProperty.resolveWith((state) {
                      return Colors
                          .blueGrey; // Or dynamically calculate based on state
                    })),
                    onPressed: controller.pickImage,
                    child: const Text(
                      "Pick Image",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: Obx(
          () => controller.imagePicked.value
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: controller.pickImage,
                      child: const Text(
                        "Pick Another Image",
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                        style: ButtonStyle(backgroundColor:
                            WidgetStateProperty.resolveWith((state) {
                          return Colors.blueGrey;
                        })),
                        onPressed: controller.removeBackground,
                        child: const Text(
                          "Remove Background",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )
              : const SizedBox(height: 0),
        ),
      ),
    );
  }
}
