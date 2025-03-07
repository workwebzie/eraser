
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:eraser/api.dart';
 
 
 
import 'package:image_picker/image_picker.dart';
 
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class BackgroundRemoverController extends GetxController {
  var imagePath = "".obs;
  var imagePicked = false.obs;
  var removed = false.obs;
  var value = 0.5.obs;
  Uint8List? image;
  final picker = ImagePicker();
  ScreenshotController screenshotController = ScreenshotController();

  Future pickImage() async {
      removed.value=false;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      imagePicked.value = true;
    }
  }

  Future<void> removeBackground() async {
    if (imagePath.value.isNotEmpty) {
      image = await Api.removeBg(imagePath.value);
      if (image != null) {
        removed.value = true;
      }
    }
  }

  Future<void> downloadToExternal(String fileName) async {
    var permission = await Permission.storage.request();
    if (permission.isGranted) {
      try {
        final directory = await getExternalStorageDirectory();
        if (directory == null) return;

        final downloadsDirectory = Directory('${directory.path}/Download');
        if (!await downloadsDirectory.exists()) {
          await downloadsDirectory.create(recursive: true);
        }

        if (!fileName.endsWith('.png')) {
          fileName = '$fileName.png';
        }

        await screenshotController.captureAndSave(
          downloadsDirectory.path,
          delay: Duration(milliseconds: 100),
          fileName: fileName,
          pixelRatio: 1.0,
        );

        Get.snackbar( "Image Saved Succesfully","");

        print('File saved at: ${downloadsDirectory.path}/$fileName');
        image?.clear();
        imagePath.value="";
        removed.value=false;
      } catch (e) {
        print('Error: $e');
      }
    } else {
      print('Permission denied. Please grant storage access.');
    }
  }
}
